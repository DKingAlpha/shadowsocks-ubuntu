#include
/bin/mkdir -p '/usr/local/include/sodium'
/bin/mkdir -p '/usr/local/lib'
bin/mkdir -p '/usr/local/lib/pkgconfig'

/usr/bin/install -c .libs/libsodium.so.18.1.0 /usr/local/lib/libsodium.so.18.1.0
/usr/bin/install -c -m 644  sodium/core.h sodium/crypto_aead_aes256gcm.h sodium
/usr/bin/install -c -m 644  sodium.h '/usr/local/include/.'
/usr/bin/install -c   libsodium.la '/usr/local/lib'
/usr/bin/install -c .libs/libsodium.so /usr/local/lib/libsodium.so.18.1.0
/usr/bin/install -c .libs/libsodium.lai /usr/local/lib/libsodium.lai
/usr/bin/install -c .libs/libsodium.a /usr/local/lib/libsodium.a
/usr/bin/install -c -m 644 libsodium.pc '/usr/local/lib/pkgconfig'

cd /usr/local/lib
ln -s -f libsodium.so.18.1.0 libsodium.so.18
ln -s -f libsodium.so.18.1.0 libsodium.so
chmod 644 /usr/local/lib/libsodium.a
ranlib /usr/local/lib/libsodium.a
ldconfig -n /usr/local/lib


