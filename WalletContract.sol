//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

//wallet contract
contract WalletContract {
    struct  Node {
        address ownerAddress;
        string userName;
        address[] shareHolders;
        address[] temporaryShareHolders;
        address[] holderRequestAcceptedHolders;
        address[] holderRequestRejectedHolders;
        string[] myShares;
        string[] releasedShares;
        address[] secretOwners;
        string email;
        string vaultHash;
        State state;
    }
    struct HolderRequest{
        address requesterAddress;
        address receiverAddress;
    }
    struct ShareRequest{
        address requesterAddress;
        string userName;
    }
    struct Share{
        address secretOwner;
        address shareHolder;
        string sharedString;
    }
    enum State { REGISTERED,SHAREHOLDER_REQUESTED, SHAREHOLDER_ACCEPTED, DISTRIBUTED,RECOVERY_REQUESTED,RECOVERY_ACCEPTED }
    mapping (address => Node ) private  publicAddressToNodeMap;
    mapping (string => address ) private  userNameToPublicAddressMap;
}
