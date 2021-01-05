-module(students).

-export([createStudents/1, initStudent/1]).

initStudent(StudentsQueue) -> listen(StudentsQueue).

listen(StudentsQueue) ->
    Wait = rand:uniform(10) * 40,
    timer:sleep(Wait),
    Student = randomStudent(),
    StudentsQueue ! {new_student, Student, self()},

    receive
        student_added -> listen(StudentsQueue);
        office_is_closed -> ok
    end.

randomNames(RandomNumber) ->
    lists:nth(RandomNumber,
              ["Ala",
               "Kasia",
               "Basia",
               "Ola",
               "Zuzia",
               "Karolina",
               "Aga",
               "Julka",
               "Kamila",
               "Matylda",
               "Marek",
               "Jarek",
               "Jasiek",
               "Bartek",
               "Stefan",
               "Romek",
               "Tomek",
               "Karol",
               "Jurek"]).

randomRequest(RandomNumber) ->
    lists:nth(RandomNumber,
              ["zaswiadczenie",
               "pieczatka",
               "warunek",
               "stypendium",
               "skarga",
               "urlop dziekanski",
               "wizyta starosty",
               "legitymacja",
               "grupa poscigowa"]).

randomStudent() ->
    RandomNumber1 = rand:uniform(19),
    RandomNumber2 = rand:uniform(9),
    {student,
     randomNames(RandomNumber1),
     randomRequest(RandomNumber2)}.

createStudents(QueuePid) ->
    %StudentPid = spawn(students, initStudent, [QueuePid]).
    spawn(students,
          initStudent,
          [QueuePid]).    %io:format("StudentPid ~p ~n", [StudentPid]).

