python
import sys
sys.path.insert(0, '/root/pretty-printer-libcxx-gdb')
from libcxx.v1.printers import register_libcxx_printer_loader
register_libcxx_printer_loader ()
end

set history save on
set print pretty on
# set pagination off
set confirm off
handle SIGUSR1 noprint nostop
handle SIGUSR2 noprint nostop
