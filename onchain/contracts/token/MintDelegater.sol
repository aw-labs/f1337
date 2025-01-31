// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

// import "hardhat/console.sol";
import {IERC1155Receiver} from "@openzeppelin/contracts/token/ERC1155/IERC1155Receiver.sol";

interface IMintableToken {
    function mint() external returns (uint);

    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 value,
        bytes memory data
    ) external;
}

contract MintDelegater is IERC1155Receiver {
    IMintableToken public token;

    constructor(address _token) {
        token = IMintableToken(_token);
    }

    function mint(address _to) external returns (uint lotteryNumber_) {
        lotteryNumber_ = token.mint();
        if (lotteryNumber_ == 1337) {
            token.safeTransferFrom(address(this), _to, 1, 1, ""); //ID 1
        } else {
            token.safeTransferFrom(address(this), _to, 0, 1, ""); //ID 0
        }
    }

    function onERC1155Received(
        address,
        address,
        uint256,
        uint256,
        bytes calldata
    ) external pure override returns (bytes4) {
        return IERC1155Receiver.onERC1155Received.selector;
    }

    function onERC1155BatchReceived(
        address,
        address,
        uint256[] calldata,
        uint256[] calldata,
        bytes calldata
    ) external pure override returns (bytes4) {
        return IERC1155Receiver.onERC1155BatchReceived.selector;
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view override returns (bool) {
        return supportsInterface(interfaceId);
    }
}
