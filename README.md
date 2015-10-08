spawn-fcgi-watcher
===================

1. 地址
 * https://github.com/switch-st/spawn-fcgi-watcher.git

2. 说明
 * 在spawn-fcgi的基础上增加监控功能，首次启动成功后，自动拉起之后退出的fcgi进程
 * 基于spawn-fcgi 1.6.4开发
 * 程序启动线程，捕捉SIGCHLD信号，回收退出的fcgi子进程，并启动新的fcgi进程
 * 子进程退出后会输出退出原因(打断子进程的信号)(输出结果包含**unusually**关键字)
 * 程序会将新的子进程PID写入pid文件
 * 杀死watcher进程时，会杀死所有子进程
 *
 * 欢迎补充。

3. 编译
 * ./autogen.sh
 * ./configure [--prefix=/path/to/bin]
 * make && make install

4. 调用
	``` shell
	switch@switch-pc:cgi-bin$ ./spawn-fcgi-watcher
	Usage: spawn-fcgi [options] [-- <fcgiapp> [fcgi app arguments]]

	spawn-fcgi v1.6.4 - spawns FastCGI processes

	Options:
	-f <path>      filename of the fcgi-application (deprecated; ignored if
			<fcgiapp> is given; needs /bin/sh)
	-d <directory> chdir to directory before spawning
	-a <address>   bind to IPv4/IPv6 address (defaults to 0.0.0.0)
	-p <port>      bind to TCP-port
	-s <path>      bind to Unix domain socket
	-M <mode>      change Unix domain socket mode (octal integer, default: allow
			read+write for user and group as far as umask allows it)
	-C <children>  (PHP only) numbers of childs to spawn (default: not setting
			the PHP_FCGI_CHILDREN environment variable - PHP defaults to 0)
	-F <children>  number of children to fork (default 1)
	-b <backlog>   backlog to allow on the socket (default 1024)
	-P <path>      name of PID-file for spawned process (ignored in no-fork mode)
	-n             no fork (for daemontools)
	-v             show version
	-?, -h         show this help
	(root only)
	-c <directory> chroot to directory
	-S             create socket before chroot() (default is to create the socket
			in the chroot)
	-u <user>      change to user-id
	-g <group>     change to group-id (default: primary group of user if -u
			is given)
	-U <user>      change Unix domain socket owner to user-id
	-G <group>     change Unix domain socket group to group-id
	```

5. 监控脚本
	* script目录下是我在项目中使用的脚本，包括启动服务、停止服务、异常监控脚本。
	* script/Monitor/WatcherMonitor.sh监控spawn-fcgi-watcher进程，随时拉起。
	* script/Monitor/ProcMonitor.sh监控子进程异常退出，并发送邮件。

6. 许可证
	* 程序采用MIT许可证，并尊重原作者([**jan kneschke** && **stefan bühler**](./AUTHORS))许可证
    * 本程序[**许可证**](./LICENSE)，spawn-fcgi[**许可证**](./COPYING)
    * 如许可证有任何问题，请联系**switch**(switch.st@gmail.com)，我将及时更正

7. write by [**switch**](switch.st@gmail.com)
