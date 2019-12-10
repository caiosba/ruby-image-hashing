#!/usr/bin/env python
# isort:skip_file

import argparse
import os
import sys

sys.path.append(os.path.join(os.path.dirname(__file__), "../.."))

from pdqhashing.hasher.pdq_hasher import PDQHasher
from pdqhashing.types.hash256 import Hash256

hashingMetadata = PDQHasher.HashingMetadata()
pdqHasher = PDQHasher()
hashAndQuality1 = pdqHasher.fromFile(sys.argv[1], hashingMetadata)
hash1 = hashAndQuality1.getHash()
hashAndQuality2 = pdqHasher.fromFile(sys.argv[2], hashingMetadata)
hash2 = hashAndQuality2.getHash()
delta = hash1.hammingDistance(hash2)

print(delta)
