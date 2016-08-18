# Обновление Directum

Заметки по результатам обновления в Directum с версии 4.9.1 на 5.2.1
в мае 2016 года.

## Предварительная настройка

### Версии Windows

Directum 5.2 не работает на Windows Server 2003,
а серверная часть к тому же на Windows XP.
Поэтому обновление производилось не "на месте", а на новый сервер
Windows Server 2008 R2.

### MS SQL

*До установки* MS SQL нужно убедиться, что на сервере установлена русская локаль
(Russia).

Можно устанавливать MS SQL в минимальной конфигурации,
однако есть смысл сразу же добавить к нему компоненту Full Text Search.
Это можно сделать и позже в любое время.

Установка Directum зачастую требует переименования хоста с установленным MS SQL.
В этом случае *после* переименования требуется выполнить команду:

```sql
sp_dropserver <old_name>;
GO
sp_addserver <new_name>, local;
GO
```

Directum требует настройки:

```sql
sp_configure 'show advanced options', 1;
RECONFIGURE;
sp_configure 'clr enabled', 1;
RECONFIGURE;
```

Если планируется использовать (для администрирования) команду xp_cmdshell
(например `xp_cmdshell 'net use z: \\host\folder'`), её требуется разрешить:

```sql
EXEC sp_configure 'show advanced options', 1
GO
RECONFIGURE
GO
EXEC sp_configure 'xp_cmdshell', 1
RECONFIGURE
```

### Firewall

Требуется вручную открыть порты (Windows Firewall with Advanced Security)
для служб Directum и для MS SQL:

  * MS SQL:  1433
  * Session: 32300
  * W-flow:  32310
  * Storage: 32320

### IIS

Установку IIS следует делать по инструкции администратора.
Суть: требуется установка компонент

  * ASP.Net
  * ASP
  * Management Service

Требуется добавить в MIME Types строку

  * mp4: video/mpeg

## Установка / Обновление  
