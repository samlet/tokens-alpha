pragma solidity ^0.4.24;


contract ECDSA {

    function verify() public returns (bool) {
        bytes32 message = ethMessageHash("TEST");

        bytes memory sig = hex"bceab59162da5e511fb9c37fda207d443d05e438e5c843c57b2d5628580ce9216ffa0335834d8bb63d86fb42a8dd4d18f41bc3a301546e2c47aa1041c3a1823701";
        address addr = 0x999471bb43b9c9789050386f90c1ad63dca89106;

        return recover(message, sig) == addr;
    }

    /**
     * @dev Recover signer address from a message by using their signature
     * @param hash bytes32 message, the hash is the signed message. What is recovered is the signer address.
     * @param sig bytes signature, the signature is generated using web3.eth.sign()
     */
    function recover(bytes32 hash, bytes sig) internal returns (address) {
        bytes32 r;
        bytes32 s;
        uint8 v;

        // Check the signature length
        if (sig.length != 65) {
            return (address(0));
        }

        // Divide the signature in r, s and v variables
        // ecrecover takes the signature parameters, and the only way to get them
        // currently is to use assembly.
        // solium-disable-next-line security/no-inline-assembly
        assembly {
            r := mload(add(sig, 32))
            s := mload(add(sig, 64))
            v := byte(0, mload(add(sig, 96)))
        }

        // Version of signature should be 27 or 28, but 0 and 1 are also possible versions
        if (v < 27) {
            v += 27;
        }

        // If the version is correct return the signer address
        if (v != 27 && v != 28) {
            return (address(0));
        } else {
            // solium-disable-next-line arg-overflow
            return ecrecover(hash, v, r, s);
        }
    }

    /**
    * @dev prefix a bytes32 value with "\x19Ethereum Signed Message:" and hash the result
    */
    function ethMessageHash(string message) internal pure returns (bytes32) {
        return keccak256(
            "\x19Ethereum Signed Message:\n32", keccak256(message)
        );
    }
}

/*
// ⊕ [Verification of externally created ECDSA signatures in Solidity](https://gist.github.com/BjornvdLaan/e41d292339bbdebb831d0b976e1804e8)
package main

import (
	"crypto/ecdsa"
	"fmt"

	"crypto/rand"
	"encoding/hex"
	"github.com/ethereum/go-ethereum/common/math"
	"github.com/ethereum/go-ethereum/crypto"
	"github.com/ethereum/go-ethereum/crypto/secp256k1"
	"github.com/miguelmota/go-solidity-sha3"
)

func main() {
	key := KeyGen()
	message := "TEST"

	sig, prefixedmsg := Sign(message, key)

	fmt.Println("address:", hex.EncodeToString(crypto.PubkeyToAddress(key.PublicKey).Bytes()))
	fmt.Println("signature:", hex.EncodeToString(sig))
}

func KeyGen() (*ecdsa.PrivateKey) {
	key, err := ecdsa.GenerateKey(crypto.S256(), rand.Reader)

	if err != nil {
		panic(err)
	}

	return key
}

func Sign(message string, key *ecdsa.PrivateKey) ([]byte, []byte) {
	// Turn the message into a 32-byte hash
	hash := solsha3.SoliditySHA3(solsha3.String(message))
	// Prefix and then hash to mimic behavior of eth_sign
	prefixed := solsha3.SoliditySHA3(solsha3.String("\x19Ethereum Signed Message:\n32"), solsha3.Bytes32(hash))
	sig, err := secp256k1.Sign(prefixed, math.PaddedBigBytes(key.D, 32))

	if err != nil {
		panic(err)
	}

	return sig, prefixed
}
*/
