requires "../rules.k"

module SIGNATURERECOVERY_RECOVERSIGNATURE_PASS_ROUGH
  imports ETHEREUM-SIMULATION
  imports EVM
  imports RULES

// SignatureRecovery_recoverSignature
rule
  <k> #execute ~> CONTINUATION => #halt ~> CONTINUATION </k>
  <exit-code> 1 </exit-code>
  <mode> NORMAL </mode>
  <schedule> PETERSBURG </schedule>
  <analysis> .Map </analysis>
  <ethereum>
    <evm>
      <output> _ => #asByteStackInWidthaux(Int(#sender(#unparseByteStack(#padToWidth(32, #asByteStack(ABI_message))), ABI_v, #unparseByteStack(#padToWidth(32, #asByteStack(ABI_r))), #unparseByteStack(#padToWidth(32, #asByteStack(ABI_s))))), 31, 32, .WordStack) </output>
      <statusCode> _ => EVMC_SUCCESS </statusCode>
      <callStack> VCallStack </callStack>
      <interimStates> _ </interimStates>
      <touchedAccounts> _ => _ </touchedAccounts>
      <callState>
        <program> #asMapOpCodes(#dasmOpCodes(#parseByteStack("0x608060405260043610610041576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063ac4c464e14610046575b600080fd5b34801561005257600080fd5b5061009b600480360381019080803560001916906020019092919080356000191690602001909291908035600019169060200190929190803590602001909291905050506100dd565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b600060043560005260643560205260243560405260443560605261010060643510151561010957600080fd5b602060006080600060015afa151561012057600080fd5b60206000f300a165627a7a7230582038136b1750e87ce77bc614e57daaf1df64a600cf0cd45dcf3f827dab19c24e4f0029"), PETERSBURG)) </program>
        <programBytes> #parseByteStack("0x608060405260043610610041576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063ac4c464e14610046575b600080fd5b34801561005257600080fd5b5061009b600480360381019080803560001916906020019092919080356000191690602001909291908035600019169060200190929190803590602001909291905050506100dd565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b600060043560005260643560205260243560405260443560605261010060643510151561010957600080fd5b602060006080600060015afa151561012057600080fd5b60206000f300a165627a7a7230582038136b1750e87ce77bc614e57daaf1df64a600cf0cd45dcf3f827dab19c24e4f0029") </programBytes>
        <id> ACCT_ID </id>
        <caller> CALLER_ID </caller>
        <callData> #abiCallData("recoverSignature", #bytes32(ABI_message), #bytes32(ABI_r), #bytes32(ABI_s), #uint256(ABI_v)) ++ CD => _ </callData>
        <callValue> VCallValue </callValue>
        <wordStack> .WordStack => _ </wordStack>
        <localMem> .Map => _ </localMem>
        <pc> 0 => _ </pc>
        <gas> VGas => _ </gas>
        <memoryUsed> 0 => _ </memoryUsed>
        <previousGas> _ => _ </previousGas>
        <static> false </static>
        <callDepth> VCallDepth => _ </callDepth>
      </callState>
      <substate>
        <selfDestruct> VSelfDestruct </selfDestruct>
        <log> _ => VLog </log>
        <refund> _ => VRefund </refund>
      </substate>
      <gasPrice> _ </gasPrice>
      <origin> ORIGIN_ID </origin>
      <previousHash> _ </previousHash>
      <ommersHash> _ </ommersHash>
      <coinbase> _ </coinbase>
      <stateRoot> _ </stateRoot>
      <transactionsRoot> _ </transactionsRoot>
      <receiptsRoot> _ </receiptsRoot>
      <logsBloom> _ </logsBloom>
      <difficulty> _ </difficulty>
      <number> _ </number>
      <gasLimit> _ </gasLimit>
      <gasUsed> _ </gasUsed>
      <timestamp> TIME </timestamp>
      <extraData> _ </extraData>
      <mixHash> _ </mixHash>
      <blockNonce> _ </blockNonce>
      <ommerBlockHeaders> _ </ommerBlockHeaders>
      <blockhash> _ </blockhash>
    </evm>
    <network>
      <activeAccounts> SetItem(ACCT_ID) SetItem(1) _ </activeAccounts>
      <accounts>
          <account>
          <acctID> 1 </acctID>
          <balance> 0 </balance>
          <code> .WordStack </code>
          <storage> .Map </storage>
          <origStorage> _ </origStorage>
          <nonce> _ </nonce>
        </account>
        <account>
          <acctID> ACCT_ID </acctID>
          <balance> ACCT_ID_balance </balance>
          <code> #parseByteStack("0x608060405260043610610041576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063ac4c464e14610046575b600080fd5b34801561005257600080fd5b5061009b600480360381019080803560001916906020019092919080356000191690602001909291908035600019169060200190929190803590602001909291905050506100dd565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b600060043560005260643560205260243560405260443560605261010060643510151561010957600080fd5b602060006080600060015afa151561012057600080fd5b60206000f300a165627a7a7230582038136b1750e87ce77bc614e57daaf1df64a600cf0cd45dcf3f827dab19c24e4f0029") </code>
          <storage> .Map
           _:Map </storage>
          <origStorage> _ </origStorage>
          <nonce> _ </nonce>
        </account>
       ... 
      </accounts>
      <txOrder> _ </txOrder>
      <txPending> _ </txPending>
      <messages> _ </messages>
    </network>
  </ethereum>
requires #rangeAddress(ACCT_ID)
andBool #notPrecompileAddress(ACCT_ID)
andBool #rangeAddress(CALLER_ID)
andBool #rangeAddress(ORIGIN_ID)
andBool #rangeUInt(48, TIME)
andBool #rangeUInt(256, ACCT_ID_balance)
andBool VCallDepth <=Int 1024
andBool #rangeUInt(256, VCallValue)

    andBool (#rangeBytes(32, ABI_message)
    andBool (#rangeBytes(32, ABI_r)
    andBool (#rangeBytes(32, ABI_s)
    andBool (#rangeUInt(256, ABI_v)
    andBool (#sizeWordStack(CD) <=Int 1250000000
    andBool (VGas >=Int 3000000
    andBool (VCallValue ==Int 0
    andBool (ABI_v <Int 256
    andBool (VCallDepth <Int 1024))))))))) 

endmodule
