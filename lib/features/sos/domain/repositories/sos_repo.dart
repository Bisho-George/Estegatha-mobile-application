abstract class SosRepo{
  Future<int> createSosPin(String sos);
  Future<int> sendSos({String type = 'INIT_SOS'});
}