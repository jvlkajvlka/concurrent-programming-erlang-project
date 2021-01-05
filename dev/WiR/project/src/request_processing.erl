-module(request_processing).

-export([requestProcessing/4]).

requestProcessing(CaseType,
                  {student, Name, CaseToProcess}, TimeToProcess,
                  WorkerName) ->
    case CaseType of
        "zaswiadczenie" ->
            io:format("~s podszedl do ~s. Sprawa: ~s -> Pracownik "
                      "wystawi zaswiadczenie. Zajmie mu to "
                      "~p min.~n",
                      [Name, WorkerName, CaseToProcess, TimeToProcess]),
            timer:sleep(TimeToProcess * 100);
        "pieczatka" ->
            io:format("~s podszedl do ~s. Sprawa: ~s -> Pracownik "
                      "podbije dokument. Zajmie mu to ~p min.~n",
                      [Name, WorkerName, CaseToProcess, TimeToProcess]),
            timer:sleep(TimeToProcess * 100);
        "warunek" ->
            io:format("~s podszedl do ~s. Sprawa: ~s -> Student "
                      "zlozy wnionek o warunek. Zajmie mu to "
                      "~p min.~n",
                      [Name, WorkerName, CaseToProcess, TimeToProcess]),
            timer:sleep(TimeToProcess * 100);
        "stypendium" ->
            io:format("~s podszedl do ~s. Sprawa: ~s -> Student "
                      "zlozy wniosek o stypendium. Zajmie mu "
                      "to ~p min.~n",
                      [Name, WorkerName, CaseToProcess, TimeToProcess]),
            timer:sleep(TimeToProcess * 100);
        "skarga" ->
            io:format("~s podszedl do ~s. Sprawa: ~s -> Student "
                      "zlozy skarge. Zajmie mu to ~p min.~n",
                      [Name, WorkerName, CaseToProcess, TimeToProcess]),
            timer:sleep(TimeToProcess * 100);
        "urlop dziekanski" ->
            io:format("~s podszedl do ~s. Sprawa: ~s -> Pracownik "
                      "wprowadzi zmiany odnosnie toku studiow. "
                      "Zajmie mu to ~p min.~n",
                      [Name, WorkerName, CaseToProcess, TimeToProcess]),
            timer:sleep(TimeToProcess * 100);
        "wizyta starosty" ->
            io:format("~s podszedl do ~s. Sprawa: ~s -> Starosta "
                      "uzyska potrzebne informacje. Zajmie "
                      "mu to ~p min.~n",
                      [Name, WorkerName, CaseToProcess, TimeToProcess]),
            timer:sleep(TimeToProcess * 100);
        "legitymacja" ->
            io:format("~s podszedl do ~s. Sprawa: ~s -> Student "
                      "odbierze legitymacje. Zajmie mu to ~p "
                      "min.~n",
                      [Name, WorkerName, CaseToProcess, TimeToProcess]),
            timer:sleep(TimeToProcess * 100);
        "grupa poscigowa" ->
            io:format("~s podszedl do ~s. Sprawa: ~s -> Pracownik "
                      "udzieli informacji. Zajmie mu to ~p "
                      "min.~n",
                      [Name, WorkerName, CaseToProcess, TimeToProcess]),
            timer:sleep(TimeToProcess * 100)
    end.
