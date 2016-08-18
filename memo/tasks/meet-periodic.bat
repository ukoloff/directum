@echo off
chcp 1251
"%programfiles(x86)%\Common Files\NPO Computer Shared\IS-Builder\SAJobRunner.exe" -S=DIRECTUM -D=DIRECTUM -CT=Script -F=PeriodicMeetingsProcessingAgent -R="ReminderDayCount=14"
