python
import sys
sys.path.insert(0, '/root/pretty-printer-libcxx-gdb')
from libcxx.v1.printers import register_libcxx_printer_loader
register_libcxx_printer_loader ()
end

set history save on
handle SIGUSR1 noprint nostop
handle SIGUSR2 noprint nostop
