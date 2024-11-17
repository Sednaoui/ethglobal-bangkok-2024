// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:web3dart/web3dart.dart' as _i1;
import 'dart:typed_data' as _i2;

final _contractAbi = _i1.ContractAbi.fromJson(
  '[{"inputs":[{"internalType":"address","name":"_manager","type":"address"}],"stateMutability":"nonpayable","type":"constructor"},{"inputs":[{"internalType":"bytes32","name":"group","type":"bytes32"},{"components":[{"internalType":"address","name":"target","type":"address"},{"internalType":"string","name":"name","type":"string"},{"internalType":"bytes32","name":"description","type":"bytes32"},{"internalType":"bytes32","name":"logo","type":"bytes32"}],"internalType":"struct KidMerchantsRegistry.Entry","name":"entry","type":"tuple"}],"name":"addEntry","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"bytes32","name":"group","type":"bytes32"}],"name":"getGroupEntries","outputs":[{"components":[{"internalType":"address","name":"target","type":"address"},{"internalType":"string","name":"name","type":"string"},{"internalType":"bytes32","name":"description","type":"bytes32"},{"internalType":"bytes32","name":"logo","type":"bytes32"}],"internalType":"struct KidMerchantsRegistry.Entry[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"manager","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"","type":"bytes32"},{"internalType":"uint256","name":"","type":"uint256"}],"name":"registry","outputs":[{"internalType":"address","name":"target","type":"address"},{"internalType":"string","name":"name","type":"string"},{"internalType":"bytes32","name":"description","type":"bytes32"},{"internalType":"bytes32","name":"logo","type":"bytes32"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"group","type":"bytes32"},{"internalType":"uint256","name":"index","type":"uint256"}],"name":"removeEntry","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_newManager","type":"address"}],"name":"setManager","outputs":[],"stateMutability":"nonpayable","type":"function"}]',
  'KidsMerchantRegistry',
);

class KidsMerchantRegistry extends _i1.GeneratedContract {
  KidsMerchantRegistry({
    required _i1.EthereumAddress address,
    required _i1.Web3Client client,
    int? chainId,
  }) : super(
          _i1.DeployedContract(
            _contractAbi,
            address,
          ),
          client,
          chainId,
        );

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> addEntry(
    _i2.Uint8List group,
    dynamic entry, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, '4e3f143e'));
    final params = [
      group,
      entry,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<dynamic>> getGroupEntries(
    _i2.Uint8List group, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, '87db6384'));
    final params = [group];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as List<dynamic>).cast<dynamic>();
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i1.EthereumAddress> manager({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, '481c6a75'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as _i1.EthereumAddress);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<Registry> registry(
    _i2.Uint8List $param3,
    BigInt $param4, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[4];
    assert(checkSignature(function, 'd81a044e'));
    final params = [
      $param3,
      $param4,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return Registry(response);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> removeEntry(
    _i2.Uint8List group,
    BigInt index, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[5];
    assert(checkSignature(function, 'e5b0903e'));
    final params = [
      group,
      index,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> setManager(
    _i1.EthereumAddress _newManager, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[6];
    assert(checkSignature(function, 'd0ebdbe7'));
    final params = [_newManager];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }
}

class Registry {
  Registry(List<dynamic> response)
      : target = (response[0] as _i1.EthereumAddress),
        name = (response[1] as String),
        description = (response[2] as _i2.Uint8List),
        logo = (response[3] as _i2.Uint8List);

  final _i1.EthereumAddress target;

  final String name;

  final _i2.Uint8List description;

  final _i2.Uint8List logo;
}
