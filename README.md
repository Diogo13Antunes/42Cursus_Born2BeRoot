# 42Cursus-Born2beRoot
This project is part of the 42Lisboa curriculum and aims to create a virtual machine running Debian, as well as set up a server by installing and configuring multiple services and security rules such as APT, AppArmor, SSH, UFW, sudo, Password Policy, and Crontab.

For more information see the [subject](./subject.pdf).

For this project, a CronJob was created to run a monitoring script every 10 minutes, logging system status information to the console as detailed below:

- The architecture of your operating system and its kernel version.
- The number of physical processors. • The number of virtual processors.
- The current available RAM on your server and its utilization rate as a percentage.
- The current available storage on your server and its utilization rate as a percentage.
- The current utilization rate of your processors as a percentage.
- The date and time of the last reboot. • Whether LVM is active or not.
- The number of active connections. • The number of users using the server.
- The IPv4 address of your server and its MAC (Media Access Control) address.
- The number of commands executed with the sudo program.

## Example
![Example](https://github.com/dspereira/42Cursus-Born2beRoot/blob/main/monitoring-script-log.png)
