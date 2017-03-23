/* this is a WIN32  custom file */
#ifndef CUSTOM__HH__ 
#define CUSTOM__HH__

#define WIN32 1 

#define _XOPEN_SOURCE 1
#define _ALL_SOURCE   1 
#define ANSI 1

#define MIN(a,b) (a<b)?(a):(b)
#define MAX(a,b) ( a > b ? a : b)


/* the sleep routine is define with first letter in uppercase */
/*                          and argument is 1/1000 of seconde */
/* the cfree routine is not define use of free instead */

#define sleep(x) Sleep(x*1000)	
#define cfree free 
#define XX_errno GetLastError()
#define XXS_errno WSAGetLastError()

#define EINPROGRESS  WSAEINPROGRESS 

/* ascii/ebcdic conversion routines */

#define EA_DS_STR_AS(x)
#define EA_DS_OSTR_AS(x)
#define AE_DS_STR_AS(x)

#define AE_AS_STR_DS(x)
#define AE_AS_OSTR_DS(x)

#define CONVERT_TO_ASC(a,b)
#define CONVERT_TO_EBC(a,b)


/* file extension is operating system dependant */

#define TRA_EXT ".TRC"       /* trace file extension */
#define LOG_EXT ".LOG"       /* log file extension   */
#define RVY_EXT ".RVY"       /* recovery file extension */
#define TXT_EXT ".TXT"       /* text file extension */

#define END_LINE1  10        /* end of line first char */
#define END_LINE2   0        /* end of line second char if not needed 0 */


/* fd_set is not standard and use a typedef of SOCKET instead of field */
/* 	fds_bits we redefine here */

#define fds_bits fd_array

#define mode_t int  

#include <windows.h>
#include <winbase.h>
#include <wtypes.h>

#define PACKAGE "05:CASMF WINDOWS NT"

#endif  /* custom__h__ */
