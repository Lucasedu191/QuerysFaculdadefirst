use TesteBicicleta
use master
]

SELECT local_tcp_port 
FROM sys.dm_exec_connections
WHERE local_tcp_port IS NOT NULL

EXEC master.dbo.xp_readerrorlog 0, 1, N'Server is listening on', 'ipv', NULL, NULL, N'asc'