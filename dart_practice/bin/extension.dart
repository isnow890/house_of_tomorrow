class Machine {}

void main() {
  final machine = Machine();
  machine.printing();
  machine.scanning();
}

extension MyMachineExt on Machine {
  void printing() {
    print('printing...');
  }

  void scanning() {
    print('scanning...');
  }
}
