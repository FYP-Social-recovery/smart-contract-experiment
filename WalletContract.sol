//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

//wallet contract
contract WalletContract {
    struct Node {
        address ownerAddress;
        string userName;
        address[] shareHolders;
        address[] temporaryShareHolders;
        address[] holderRequestAcceptedHolders;
        address[] holderRequestRejectedHolders;
        string[] myShares;
        string[] releasedShares;
        address[] secretOwners;
        // OwnerShareAndHolder[] sharesMap;
        // OwnerShareAndHolder[] shareHoldersMap;
        // mapping(address => string) sharesMap; //The secrets I'm holding
        // mapping(address => string) shareHoldersMap; //my shares map
        string email;
        string encryptedVault;
        State state;
    }
    struct OwnerShareAndHolder {
        address owner;
        address holder;
        string share;
    }
    struct HolderRequest {
        address requesterAddress;
        address receiverAddress;
    }
    struct ShareRequest {
        address requesterAddress;
        string userName;
    }
    struct Share {
        address secretOwner;
        address shareHolder;
        string sharedString;
    }
    enum State {
        REGISTERED,
        SHAREHOLDER_REQUESTED,
        SHAREHOLDER_ACCEPTED,
        DISTRIBUTED,
        RECOVERY_REQUESTED,
        RECOVERY_ACCEPTED
    }
    mapping(address => Node) private publicAddressToNodeMap;
    mapping(string => address) private userNameToPublicAddressMap;
    string[] private userNames;
    address[] private users;
    //OwnerShareAndHolder[] private allShares;
    mapping(address => OwnerShareAndHolder[]) private holderAddressToSharesMap;

    modifier checkIsRegistered() {
        require(
            isUserRegistered(msg.sender),
            "Owner has to register to public contract"
        );
        _;
    }

    //check the user is registered
    function isUserRegistered(address addr) public view returns (bool) {
        for (uint i = 0; i < users.length; i++) {
            if (users[i] == addr) {
                return true;
            }
        }
        return false;
    }

    //register to the wallet contract
    function registerToWalletContract(string memory name) public {
        require((!isUserRegistered(msg.sender)), "User has already registered");
        // OwnerShareAndHolder[] memory sharesMapTemp=new OwnerShareAndHolder[](0);
        // OwnerShareAndHolder[] memory shareHoldersMapTemp=new OwnerShareAndHolder[](0);
        Node memory newNode = Node({
            ownerAddress: msg.sender,
            userName: name,
            shareHolders: new address[](0),
            temporaryShareHolders: new address[](0),
            holderRequestAcceptedHolders: new address[](0),
            holderRequestRejectedHolders: new address[](0),
            myShares: new string[](0),
            releasedShares: new string[](0),
            secretOwners: new address[](0),
            // sharesMap: sharesMapTemp,
            // shareHoldersMap: shareHoldersMapTemp,
            email: "",
            encryptedVault: "",
            state: State.REGISTERED
        });
        publicAddressToNodeMap[msg.sender] = newNode;
        userNameToPublicAddressMap[name] = msg.sender;
        userNames.push(name);
        users.push(msg.sender);
        return;
    }
}
