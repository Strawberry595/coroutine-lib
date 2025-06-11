#ifndef _TREAD_H_
#define _TREAD_H_

#include <mutex>
#include <condition_variable>
#include <functional>

namespace sylar
{

    class Semaphore
    {
    private:
        std::mutex mtx;
        std::condition_variable cv;
        int count;

    public:
        explicit Semaphore(int count_ = 0) : count(count_) {};

        void wait()
        {
            std::unique_lock<std::mutex> lock(mtx);
            while (count == 0)
            {
                cv.wait(lock);
            }
            count--;
        }

        void signal()
        {
            std::unique_lock<std::mutex> lock(mtx);
            count++;
            cv.notify_one();
        }
    };

    class Thread
    {
    private:
        static void *run(void *arg);

        pid_t m_id = -1;
        pthread_t m_thread = 0;

        std::function<void()> m_cb;
        std::string m_name;

        Semaphore m_semaphore;

    public:
        Thread(std::function<void()> cb, const std::string &name);
        ~Thread();

        pid_t getId() const { return m_id; }
        const std::string &getName() const { return m_name; }
        void join();

    public:
        static pid_t GetThreadId();
        static Thread *GetThis();
        static const std::string &GetName();
        static void SetName(const std::string &name);
    };

}

#endif
