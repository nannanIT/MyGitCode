#  Thread

每个进程（线程）中访问临界资源的那段代码称为临界区（Critical Section）（临界资源是一次仅允许一个进程（线程）使用的共享资源）。每次只准许一个进程进入临界区，进入后不允许其它进程（线程）进入。不论是硬件临界资源，还是软件临界资源，多个进程（线程）必须互斥地对它进行访问。


临界区在使用时以CRITICAL_SECTION结构对象保护共享资源，并分别用EnterCriticalSection（）和LeaveCriticalSection（）函数去标识和释放一个临界区。所用到的CRITICAL_SECTION结构对象必须经过InitializeCriticalSection（）的初始化后才能使用，而且必须确保所有线程中的任何试图访问此共享资源的代码都处在此临界区的保护之下。否则临界区将不会起到应有的作用，共享资源依然有被破坏的可能。

```
// 临界区结构对象
CRITICAL_SECTION g_cs;
// 共享资源
char g_cArray[10];
UINT ThreadProc10(LPVOID pParam)
{
    // 进入临界区
    EnterCriticalSection(&g_cs);
    // 对共享资源进行写入操作
    for (int i = 0; i < 10; i++)
    {
    g_cArray[i]  = a;
    Sleep(1);
    }
    // 离开临界区
    LeaveCriticalSection(&g_cs);
    return 0;
}
UINT ThreadProc11(LPVOID pParam)
{
    // 进入临界区
    EnterCriticalSection(&g_cs);
    // 对共享资源进行写入操作
    for (int i = 0; i < 10; i++)
    {
        g_cArray[10 - i - 1] = b;
        Sleep(1);
    }
    // 离开临界区
    LeaveCriticalSection(&g_cs);
    return 0;
}
……
void CSample08View::OnCriticalSection()
{
    // 初始化临界区
    InitializeCriticalSection(&g_cs);
    // 启动线程
    AfxBeginThread(ThreadProc10, NULL);
    AfxBeginThread(ThreadProc11, NULL);
    // 等待计算完毕
    Sleep(300);
    // 报告计算结果
    CString sResult = CString(g_cArray);
    AfxMessageBox(sResult);
}
```

互斥量与临界区的作用非常相似，但互斥量是可以命名的，也就是说它可以跨越进程使用。所以创建互斥量需要的资源更多，所以如果只为了在进程内部是用的话使用临界区会带来速度上的优势并能够减少资源占用量 。因为互斥量是跨进程的互斥量一旦被创建，就可以通过名字打开它。
互斥量(Mutex)，信号灯(Semaphore)，事件(Event)都可以被跨越进程使用来进行同步数据操作，而其他的对象与数据同步操作无关，但对于进程和线程来讲，如果进程和线程在运行状态则为无信号状态，在退出后为有信号状态。所以可以使用WaitForSingleObject来等待进程和 线程退出。
通过互斥量可以指定资源被独占的方式使用，但如果有下面一种情况通过互斥量就无法处理，比如现在一位用户购买了一份三个并发访问许可的数据库系统，可以根据用户购买的访问许可数量来决定有多少个线程/进程能同时进行数据库操作，这时候如果利用互斥量就没有办法完成这个要求，信号灯对象可以说是一种资源计数器。
