enum Materials {
  IRON_STEEL,
  CAN,
  PAPER,
  GLASS,
  PLASTIC
}

extension MaterialsExt on Materials {
  static const Map<Materials, String> keys = {
    Materials.IRON_STEEL: 'IRON_STEEL',
    Materials.CAN: 'CAN',
    Materials.PAPER: 'PAPER',
    Materials.GLASS: 'GLASS',
    Materials.PLASTIC: 'PLASTIC',

  };

  static const Map<Materials, String> values = {
    Materials.IRON_STEEL: '1',
    Materials.CAN: '2',
    Materials.PAPER: '3',
    Materials.GLASS: '4',
    Materials.PLASTIC: '5',
  };

  String? get key => keys[this];
  String? get value => values[this];

}

enum Type {
  personal,
  corporate
}