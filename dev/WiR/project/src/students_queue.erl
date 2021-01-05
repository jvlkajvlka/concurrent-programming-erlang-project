-module(students_queue).

-export([initQueue/1]).

initQueue(WorkersNumber) ->
    io:format("Dziekanat otwarty. Zapraszamy!~n"),
    Queue = fifo:newFifo(),
    listen(Queue, false, WorkersNumber).

listen(Queue, DeansOfficeIsClosed, WorkersNumber) ->
    receive
        {new_student, {student, Name, Case}, ProducerPid} ->
            if DeansOfficeIsClosed ->
                   ProducerPid ! office_is_closed;
               true ->
                   io:format("~s -> sprawa: ~s~n", [Name, Case]),
                   QueueBuffer = fifo:pushToFifo(Queue,
                                                 {student, Name, Case}),
                   ProducerPid ! student_added,
                   listen(QueueBuffer, false, WorkersNumber)
            end;
        {case_handle, WorkerPid} ->
            NotEmpty = fifo:notEmpty(Queue),
            if NotEmpty ->
                   {Student, QueueBuffer} = fifo:popFromFifo(Queue),
                   {student, Name, Case} = Student,
                   io:format("Student ~s wchodzi do dziekanatu.~n",
                             [Name]),
                   WorkerPid ! {Case, Student},
                   listen(QueueBuffer, false, WorkersNumber);
               true ->
                   WorkerPid ! queue_is_empty,
                   listen(Queue, false, WorkersNumber)
            end;
        the_end_of_work ->
            if WorkersNumber - 1 == 0 ->
                   self() ! office_is_closed,
                   listen(Queue, true, 0);
               true -> listen(Queue, false, WorkersNumber - 1)
            end;
        office_is_closed ->
            EmptyQueue = clearQueue(Queue),
            listen(EmptyQueue, true, 0)
    end.

clearQueue(Queue) ->
    NotEmpty = fifo:notEmpty(Queue),
    if NotEmpty ->
           {{student, Name, _Case}, Q} = fifo:popFromFifo(Queue),
           io:format("Student ~s nie doczekal sie.~n", [Name]),
           clearQueue(Q);
       true ->
           io:format("Dziekanat zamkniety.~nZapraszamy jutro!~n"),
           Queue
    end.
