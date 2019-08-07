MODULE PARALLEL_DATA
  USE DATATYPES
  USE GLOBAL_DATA, ONLY: MAX_STRING_LEN 
  ! Pointers
  TYPE (LLIST),    POINTER      :: LLPTRPLLCTRL !  Parallel control data
  TYPE (LLIST),    POINTER      :: LLPTRPLLRUN  !  Parallel runners data
  TYPE (LLIST),    POINTER      :: TAIL
  ! Scalars
  INTEGER, PARAMETER  :: NRUNNERCOLS = 3
  INTEGER             :: NUMRUNNERS
  INTEGER             :: IVERBRUNNER
  LOGICAL             :: AUTOSTOPRUNNERS
  LOGICAL             :: DOPLL
  DOUBLE PRECISION    :: TIMEOUTFAC
  DOUBLE PRECISION    :: WAITPLL, WAITRUNNERSPLL
  ! Arrays
  CHARACTER(LEN=40),                DIMENSION(NRUNNERCOLS) :: RUNNERCOLS
  CHARACTER(LEN=MAX_STRING_LEN), ALLOCATABLE, DIMENSION(:) :: RUNNERDIR
  CHARACTER(LEN=20),             ALLOCATABLE, DIMENSION(:) :: RUNNERNAME
  DOUBLE PRECISION,              ALLOCATABLE, DIMENSION(:) :: RUNTIME
  !
  DATA RUNNERCOLS /'RUNNERNAME','RUNNERDIR ','RUNTIME  '/
END MODULE PARALLEL_DATA