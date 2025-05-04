#define REPETIONS_NUMBER 2
#define INCREMENT 1

int shared_data = 0;

proctype increase_counter() {
  int temp;
  int i = 0;
  do
  :: i < REPETIONS_NUMBER -> 
    temp = shared_data;
    temp = temp + INCREMENT;
    shared_data = temp;
    i++;
  :: else -> break;
  od
}

proctype reduce_counter() {
  int temp;
  int i = 0;
  do
  :: i < REPETIONS_NUMBER -> 
    temp = shared_data;
    temp = temp - INCREMENT;
    shared_data = temp;
    i++;
  :: else -> break;
  od
}

init {
  run increase_counter();
  run reduce_counter();
  (_nr_pr == 1) -> printf("shared_data = %d\n", shared_data);
}
