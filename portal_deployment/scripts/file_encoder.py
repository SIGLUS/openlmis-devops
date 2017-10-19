import base64
import sys

value_to_encode = sys.argv[1]
print base64.standard_b64encode(value_to_encode)
