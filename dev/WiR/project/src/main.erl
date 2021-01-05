-module(main).

-export([deansOffice/0]).

deansOffice() ->
    Start = 8,
    End = 16,
    WorkersNumber = 5,

    QueuePid = spawn(students_queue,
                     initQueue,
                     [WorkersNumber]),
    students:createStudents(QueuePid),
    timer:sleep(100),
    office_worker:createWorker(QueuePid,
                               Start,
                               End,
                               WorkersNumber).
