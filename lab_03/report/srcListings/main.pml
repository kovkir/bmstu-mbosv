mtype = { AUTH, OK, REQ, DATA, ACK, FIN };

proctype Sender(chan ch; int msg_count) {
  ch?AUTH, 1;
  printf("\nОтправитель <- AUTH");
  printf("\nОтправитель -> OK");
  ch!OK, 0;

  ch?REQ, 0;
  printf("\nОтправитель <- REQ");

  int ind = 1;
  int number = 2025;
  do
  :: ind <= msg_count -> {
    printf("\n(%d) Отправитель -> DATA = %d", ind, number);
    ch!DATA, number;
    ch?ACK, ind;
    printf("\n(%d) Отправитель <- ACK", ind);

    number++;
    ind++;
  }
  :: else -> break;
  od;

  ch?FIN, 0;
  printf("\nОтправитель <- FIN");
  printf("\nОтправитель -> OK");
  ch!OK, 0;
}

proctype Receiver(chan ch; int msg_count) {
  printf("\nПолучатель  -> AUTH");
  ch!AUTH, 1;
  ch?OK, 0;
  printf("\nПолучатель  <- OK");

  printf("\nПолучатель  -> REQ");
  ch!REQ, 0;

  int ind = 1;
  int receive_data;
  do
  :: ind <= msg_count -> {
    ch?DATA, receive_data;
    printf("\n(%d) Получатель  <- DATA = %d", ind, receive_data);
    printf("\n(%d) Получатель  -> ACK", ind);
    ch!ACK, ind;

    ind++;
  }
  :: else -> break
  od;

  printf("\nПолучатель  -> FIN");
  ch!FIN, 0;
  ch?OK, 0;
  printf("\nПолучатель  <- OK\n");
}

init {
  chan ch = [3] of { mtype, int };
  int msg_count = 4;

  run Receiver(ch, msg_count);
  run Sender(ch, msg_count);
}
