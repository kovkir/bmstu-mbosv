#define REPETIONS_NUMBER 2
#define INCREMENT 1

int shared_data = 0;
show byte mutex = 0;

#define lock(mutex)         \
  do                        \
  :: atomic {               \
    if                      \
    :: mutex == 0 -> {      \
      mutex = 1;            \
      break;                \
    }                       \
    :: else -> skip;        \
    fi                      \
  }                         \
  od

#define unlock(mutex)       \
  mutex = 0;

proctype increase_counter() {
  int temp;
  int i = 0;
  do
  :: i < REPETIONS_NUMBER -> 
    lock(mutex);
    temp = shared_data;
    temp = temp + INCREMENT;
    shared_data = temp;
    unlock(mutex);
    i++;
  :: else -> break;
  od
}

proctype reduce_counter() {
  int temp;
  int i = 0;
  do
  :: i < REPETIONS_NUMBER -> 
    lock(mutex);
    temp = shared_data;
    temp = temp - INCREMENT;
    shared_data = temp;
    unlock(mutex);
    i++;
  :: else -> break;
  od
}

init {
  run increase_counter();
  run reduce_counter();
  (_nr_pr == 1) -> printf("shared_data = %d\n", shared_data);
}
