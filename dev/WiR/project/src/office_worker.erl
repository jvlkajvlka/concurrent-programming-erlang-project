-module(office_worker).

-export([createWorker/4, initWorker/4, workerName/1]).

initWorker(QueuePid, Start, End, WorkerName) ->
    WorkingTimeLeft = (End - Start) * 60,
    workerTasks(QueuePid, WorkingTimeLeft, WorkerName).

workerName(Number) ->
    lists:nth(Number,
              ["Pracownik_1",
               "Pracownik_2",
               "Pracownik_3",
               "Pracownik_4",
               "Pracownik_5"]).

randomBreakReason(RandomNumber) ->
    lists:nth(RandomNumber,
              ["idzie na kawe",
               "idzie na przerwe",
               "rozmawia z kolega",
               "sprawdza poczte"]).

workerTasks(QueuePid, WorkingTimeLeft, WorkerName) ->
    if WorkingTimeLeft =< 0 ->
           io:format("~s skonczyl prace. ~n", [WorkerName]),
           QueuePid ! the_end_of_work;
       WorkingTimeLeft > 0 ->
           QueuePid ! {case_handle, self()},
           receive
               {Request, Student} ->
                   TimeToProcess = rand:uniform(20),
                   request_processing:requestProcessing(Request,
                                                        Student,
                                                        TimeToProcess,
                                                        WorkerName),
                   workerTasks(QueuePid,
                               WorkingTimeLeft - TimeToProcess,
                               WorkerName);
               queue_is_empty ->
                   BreakTime = rand:uniform(7),
                   BreakReason = rand:uniform(4),
                   io:format("Kolejka jest pusta -> ~s ~s (~p min).~n",
                             [WorkerName,
                              randomBreakReason(BreakReason),
                              BreakTime]),
                   timer:sleep(BreakTime * 100),
                   workerTasks(QueuePid,
                               WorkingTimeLeft - BreakTime,
                               WorkerName)
           end
    end.

createWorker(QueuePid, Start, End, 1) ->
    % WorkerPid = spawn(?MODULE,
    %                   initWorker,
    %                   [QueuePid, Start, End, workerName(1)]);
    spawn(?MODULE,
          initWorker,
          [QueuePid, Start, End, workerName(1)]);
% io:format("WorkerPid ~p ~n", [WorkerPid]);
createWorker(QueuePid, Start, End, WorkersNumber)
    when WorkersNumber > 1 ->
    % WorkerPid = spawn(?MODULE,
    %                   initWorker,
    %                   [QueuePid, Start, End, workerName(WorkersNumber)]),
    spawn(?MODULE,
          initWorker,
          [QueuePid, Start, End, workerName(WorkersNumber)]),
    % io:format("WorkerPid ~p ~n", [WorkerPid]),
    createWorker(QueuePid, Start, End, WorkersNumber - 1).
