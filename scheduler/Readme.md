g++ -g -o scheduler_test \
-I../fiber \
-I../thread \
../scheduler/scheduler_test.cpp \
../scheduler/scheduler.cpp \
../fiber/fiber.cpp \
../thread/thread.cpp \
-pthread