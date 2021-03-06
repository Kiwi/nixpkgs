# Generated by carnix 0.10.0: carnix generate-nix
{ lib, buildPlatform, buildRustCrate, buildRustCrateHelpers, cratesIO, fetchgit }:
with buildRustCrateHelpers;
let inherit (lib.lists) fold;
  inherit (lib.attrsets) recursiveUpdate;
in
rec {
  crates = cratesIO;
  cargo_download = crates.crates.cargo_download."0.1.2" deps;
  __all = [ (cargo_download { }) ];
  deps.adler32."1.0.2" = { };
  deps.aho_corasick."0.5.3" = {
    memchr = "0.1.11";
  };
  deps.ansi_term."0.9.0" = { };
  deps.arrayvec."0.4.8" = {
    nodrop = "0.1.13";
  };
  deps.atty."0.2.3" = {
    termion = "1.5.1";
    libc = "0.2.44";
    kernel32_sys = "0.2.2";
    winapi = "0.2.8";
  };
  deps.base64."0.9.3" = {
    byteorder = "1.1.0";
    safemem = "0.3.0";
  };
  deps.bitflags."0.7.0" = { };
  deps.bitflags."0.9.1" = { };
  deps.bitflags."1.0.4" = { };
  deps.byteorder."1.1.0" = { };
  deps.bytes."0.4.11" = {
    byteorder = "1.1.0";
    iovec = "0.1.1";
  };
  deps.cargo_download."0.1.2" = {
    ansi_term = "0.9.0";
    clap = "2.27.1";
    conv = "0.3.3";
    derive_error = "0.0.3";
    exitcode = "1.1.2";
    flate2 = "0.2.20";
    isatty = "0.1.5";
    itertools = "0.6.5";
    lazy_static = "0.2.10";
    log = "0.3.8";
    maplit = "0.1.6";
    reqwest = "0.9.5";
    semver = "0.9.0";
    serde_json = "1.0.6";
    slog = "1.7.1";
    slog_envlogger = "0.5.0";
    slog_stdlog = "1.1.0";
    slog_stream = "1.2.1";
    tar = "0.4.13";
    time = "0.1.38";
  };
  deps.case."0.1.0" = { };
  deps.cc."1.0.3" = { };
  deps.cfg_if."0.1.2" = { };
  deps.chrono."0.2.25" = {
    num = "0.1.40";
    time = "0.1.38";
  };
  deps.clap."2.27.1" = {
    ansi_term = "0.9.0";
    atty = "0.2.3";
    bitflags = "0.9.1";
    strsim = "0.6.0";
    textwrap = "0.9.0";
    unicode_width = "0.1.4";
    vec_map = "0.8.0";
  };
  deps.cloudabi."0.0.3" = {
    bitflags = "1.0.4";
  };
  deps.conv."0.3.3" = {
    custom_derive = "0.1.7";
  };
  deps.core_foundation."0.5.1" = {
    core_foundation_sys = "0.5.1";
    libc = "0.2.44";
  };
  deps.core_foundation_sys."0.5.1" = {
    libc = "0.2.44";
  };
  deps.crc32fast."1.1.1" = { };
  deps.crossbeam."0.2.10" = { };
  deps.crossbeam_deque."0.6.2" = {
    crossbeam_epoch = "0.6.1";
    crossbeam_utils = "0.6.1";
  };
  deps.crossbeam_epoch."0.6.1" = {
    arrayvec = "0.4.8";
    cfg_if = "0.1.2";
    crossbeam_utils = "0.6.1";
    lazy_static = "1.2.0";
    memoffset = "0.2.1";
    scopeguard = "0.3.3";
  };
  deps.crossbeam_utils."0.6.1" = {
    cfg_if = "0.1.2";
  };
  deps.custom_derive."0.1.7" = { };
  deps.derive_error."0.0.3" = {
    case = "0.1.0";
    quote = "0.3.15";
    syn = "0.11.11";
  };
  deps.dtoa."0.4.2" = { };
  deps.either."1.4.0" = { };
  deps.encoding_rs."0.8.13" = {
    cfg_if = "0.1.2";
  };
  deps.exitcode."1.1.2" = { };
  deps.filetime."0.1.14" = {
    cfg_if = "0.1.2";
    redox_syscall = "0.1.31";
    libc = "0.2.44";
  };
  deps.flate2."0.2.20" = {
    libc = "0.2.44";
    miniz_sys = "0.1.10";
  };
  deps.fnv."1.0.6" = { };
  deps.foreign_types."0.3.2" = {
    foreign_types_shared = "0.1.1";
  };
  deps.foreign_types_shared."0.1.1" = { };
  deps.fuchsia_zircon."0.2.1" = {
    fuchsia_zircon_sys = "0.2.0";
  };
  deps.fuchsia_zircon."0.3.3" = {
    bitflags = "1.0.4";
    fuchsia_zircon_sys = "0.3.3";
  };
  deps.fuchsia_zircon_sys."0.2.0" = {
    bitflags = "0.7.0";
  };
  deps.fuchsia_zircon_sys."0.3.3" = { };
  deps.futures."0.1.25" = { };
  deps.futures_cpupool."0.1.7" = {
    futures = "0.1.25";
    num_cpus = "1.8.0";
  };
  deps.h2."0.1.13" = {
    byteorder = "1.1.0";
    bytes = "0.4.11";
    fnv = "1.0.6";
    futures = "0.1.25";
    http = "0.1.14";
    indexmap = "1.0.2";
    log = "0.4.6";
    slab = "0.4.0";
    string = "0.1.2";
    tokio_io = "0.1.10";
  };
  deps.http."0.1.14" = {
    bytes = "0.4.11";
    fnv = "1.0.6";
    itoa = "0.4.3";
  };
  deps.httparse."1.2.3" = { };
  deps.hyper."0.12.16" = {
    bytes = "0.4.11";
    futures = "0.1.25";
    futures_cpupool = "0.1.7";
    h2 = "0.1.13";
    http = "0.1.14";
    httparse = "1.2.3";
    iovec = "0.1.1";
    itoa = "0.4.3";
    log = "0.4.6";
    net2 = "0.2.33";
    time = "0.1.38";
    tokio = "0.1.7";
    tokio_executor = "0.1.5";
    tokio_io = "0.1.10";
    tokio_reactor = "0.1.7";
    tokio_tcp = "0.1.2";
    tokio_threadpool = "0.1.9";
    tokio_timer = "0.2.5";
    want = "0.0.6";
  };
  deps.hyper_tls."0.3.1" = {
    bytes = "0.4.11";
    futures = "0.1.25";
    hyper = "0.12.16";
    native_tls = "0.2.2";
    tokio_io = "0.1.10";
  };
  deps.idna."0.1.4" = {
    matches = "0.1.6";
    unicode_bidi = "0.3.4";
    unicode_normalization = "0.1.5";
  };
  deps.indexmap."1.0.2" = { };
  deps.iovec."0.1.1" = {
    libc = "0.2.44";
    winapi = "0.2.8";
  };
  deps.isatty."0.1.5" = {
    libc = "0.2.44";
    kernel32_sys = "0.2.2";
    winapi = "0.2.8";
  };
  deps.itertools."0.6.5" = {
    either = "1.4.0";
  };
  deps.itoa."0.3.4" = { };
  deps.itoa."0.4.3" = { };
  deps.kernel32_sys."0.2.2" = {
    winapi = "0.2.8";
    winapi_build = "0.1.1";
  };
  deps.lazy_static."0.2.10" = { };
  deps.lazy_static."1.2.0" = { };
  deps.lazycell."1.2.0" = { };
  deps.libc."0.2.44" = { };
  deps.libflate."0.1.19" = {
    adler32 = "1.0.2";
    byteorder = "1.1.0";
    crc32fast = "1.1.1";
  };
  deps.lock_api."0.1.5" = {
    owning_ref = "0.4.0";
    scopeguard = "0.3.3";
  };
  deps.log."0.3.8" = { };
  deps.log."0.4.6" = {
    cfg_if = "0.1.2";
  };
  deps.maplit."0.1.6" = { };
  deps.matches."0.1.6" = { };
  deps.memchr."0.1.11" = {
    libc = "0.2.44";
  };
  deps.memoffset."0.2.1" = { };
  deps.mime."0.3.12" = {
    unicase = "2.1.0";
  };
  deps.mime_guess."2.0.0-alpha.6" = {
    mime = "0.3.12";
    phf = "0.7.21";
    unicase = "1.4.2";
    phf_codegen = "0.7.21";
  };
  deps.miniz_sys."0.1.10" = {
    libc = "0.2.44";
    cc = "1.0.3";
  };
  deps.mio."0.6.16" = {
    iovec = "0.1.1";
    lazycell = "1.2.0";
    log = "0.4.6";
    net2 = "0.2.33";
    slab = "0.4.0";
    fuchsia_zircon = "0.3.3";
    fuchsia_zircon_sys = "0.3.3";
    libc = "0.2.44";
    kernel32_sys = "0.2.2";
    miow = "0.2.1";
    winapi = "0.2.8";
  };
  deps.miow."0.2.1" = {
    kernel32_sys = "0.2.2";
    net2 = "0.2.33";
    winapi = "0.2.8";
    ws2_32_sys = "0.2.1";
  };
  deps.native_tls."0.2.2" = {
    lazy_static = "1.2.0";
    libc = "0.2.44";
    security_framework = "0.2.1";
    security_framework_sys = "0.2.1";
    tempfile = "3.0.5";
    openssl = "0.10.15";
    openssl_probe = "0.1.2";
    openssl_sys = "0.9.39";
    log = "0.4.6";
    schannel = "0.1.14";
  };
  deps.net2."0.2.33" = {
    cfg_if = "0.1.2";
    libc = "0.2.44";
    winapi = "0.3.6";
  };
  deps.nodrop."0.1.13" = { };
  deps.num."0.1.40" = {
    num_integer = "0.1.35";
    num_iter = "0.1.34";
    num_traits = "0.1.40";
  };
  deps.num_integer."0.1.35" = {
    num_traits = "0.1.40";
  };
  deps.num_iter."0.1.34" = {
    num_integer = "0.1.35";
    num_traits = "0.1.40";
  };
  deps.num_traits."0.1.40" = { };
  deps.num_cpus."1.8.0" = {
    libc = "0.2.44";
  };
  deps.openssl."0.10.15" = {
    bitflags = "1.0.4";
    cfg_if = "0.1.2";
    foreign_types = "0.3.2";
    lazy_static = "1.2.0";
    libc = "0.2.44";
    openssl_sys = "0.9.39";
  };
  deps.openssl_probe."0.1.2" = { };
  deps.openssl_sys."0.9.39" = {
    libc = "0.2.44";
    cc = "1.0.3";
    pkg_config = "0.3.9";
  };
  deps.owning_ref."0.4.0" = {
    stable_deref_trait = "1.1.1";
  };
  deps.parking_lot."0.6.4" = {
    lock_api = "0.1.5";
    parking_lot_core = "0.3.1";
  };
  deps.parking_lot_core."0.3.1" = {
    rand = "0.5.5";
    smallvec = "0.6.7";
    rustc_version = "0.2.3";
    libc = "0.2.44";
    winapi = "0.3.6";
  };
  deps.percent_encoding."1.0.1" = { };
  deps.phf."0.7.21" = {
    phf_shared = "0.7.21";
  };
  deps.phf_codegen."0.7.21" = {
    phf_generator = "0.7.21";
    phf_shared = "0.7.21";
  };
  deps.phf_generator."0.7.21" = {
    phf_shared = "0.7.21";
    rand = "0.3.18";
  };
  deps.phf_shared."0.7.21" = {
    siphasher = "0.2.2";
    unicase = "1.4.2";
  };
  deps.pkg_config."0.3.9" = { };
  deps.quote."0.3.15" = { };
  deps.rand."0.3.18" = {
    libc = "0.2.44";
    fuchsia_zircon = "0.2.1";
  };
  deps.rand."0.5.5" = {
    rand_core = "0.2.2";
    cloudabi = "0.0.3";
    fuchsia_zircon = "0.3.3";
    libc = "0.2.44";
    winapi = "0.3.6";
  };
  deps.rand."0.6.1" = {
    rand_chacha = "0.1.0";
    rand_core = "0.3.0";
    rand_hc = "0.1.0";
    rand_isaac = "0.1.1";
    rand_pcg = "0.1.1";
    rand_xorshift = "0.1.0";
    rustc_version = "0.2.3";
    cloudabi = "0.0.3";
    fuchsia_zircon = "0.3.3";
    libc = "0.2.44";
    winapi = "0.3.6";
  };
  deps.rand_chacha."0.1.0" = {
    rand_core = "0.3.0";
    rustc_version = "0.2.3";
  };
  deps.rand_core."0.2.2" = {
    rand_core = "0.3.0";
  };
  deps.rand_core."0.3.0" = { };
  deps.rand_hc."0.1.0" = {
    rand_core = "0.3.0";
  };
  deps.rand_isaac."0.1.1" = {
    rand_core = "0.3.0";
  };
  deps.rand_pcg."0.1.1" = {
    rand_core = "0.3.0";
    rustc_version = "0.2.3";
  };
  deps.rand_xorshift."0.1.0" = {
    rand_core = "0.3.0";
  };
  deps.redox_syscall."0.1.31" = { };
  deps.redox_termios."0.1.1" = {
    redox_syscall = "0.1.31";
  };
  deps.regex."0.1.80" = {
    aho_corasick = "0.5.3";
    memchr = "0.1.11";
    regex_syntax = "0.3.9";
    thread_local = "0.2.7";
    utf8_ranges = "0.1.3";
  };
  deps.regex_syntax."0.3.9" = { };
  deps.remove_dir_all."0.5.1" = {
    winapi = "0.3.6";
  };
  deps.reqwest."0.9.5" = {
    base64 = "0.9.3";
    bytes = "0.4.11";
    encoding_rs = "0.8.13";
    futures = "0.1.25";
    http = "0.1.14";
    hyper = "0.12.16";
    hyper_tls = "0.3.1";
    libflate = "0.1.19";
    log = "0.4.6";
    mime = "0.3.12";
    mime_guess = "2.0.0-alpha.6";
    native_tls = "0.2.2";
    serde = "1.0.21";
    serde_json = "1.0.6";
    serde_urlencoded = "0.5.1";
    tokio = "0.1.7";
    tokio_io = "0.1.10";
    url = "1.6.1";
    uuid = "0.7.1";
  };
  deps.rustc_version."0.2.3" = {
    semver = "0.9.0";
  };
  deps.safemem."0.3.0" = { };
  deps.schannel."0.1.14" = {
    lazy_static = "1.2.0";
    winapi = "0.3.6";
  };
  deps.scopeguard."0.3.3" = { };
  deps.security_framework."0.2.1" = {
    core_foundation = "0.5.1";
    core_foundation_sys = "0.5.1";
    libc = "0.2.44";
    security_framework_sys = "0.2.1";
  };
  deps.security_framework_sys."0.2.1" = {
    core_foundation_sys = "0.5.1";
    libc = "0.2.44";
  };
  deps.semver."0.9.0" = {
    semver_parser = "0.7.0";
  };
  deps.semver_parser."0.7.0" = { };
  deps.serde."1.0.21" = { };
  deps.serde_json."1.0.6" = {
    dtoa = "0.4.2";
    itoa = "0.3.4";
    num_traits = "0.1.40";
    serde = "1.0.21";
  };
  deps.serde_urlencoded."0.5.1" = {
    dtoa = "0.4.2";
    itoa = "0.3.4";
    serde = "1.0.21";
    url = "1.6.1";
  };
  deps.siphasher."0.2.2" = { };
  deps.slab."0.4.0" = { };
  deps.slog."1.7.1" = { };
  deps.slog_envlogger."0.5.0" = {
    log = "0.3.8";
    regex = "0.1.80";
    slog = "1.7.1";
    slog_stdlog = "1.1.0";
    slog_term = "1.5.0";
  };
  deps.slog_extra."0.1.2" = {
    slog = "1.7.1";
    thread_local = "0.3.4";
  };
  deps.slog_stdlog."1.1.0" = {
    crossbeam = "0.2.10";
    lazy_static = "0.2.10";
    log = "0.3.8";
    slog = "1.7.1";
    slog_term = "1.5.0";
  };
  deps.slog_stream."1.2.1" = {
    slog = "1.7.1";
    slog_extra = "0.1.2";
    thread_local = "0.3.4";
  };
  deps.slog_term."1.5.0" = {
    chrono = "0.2.25";
    isatty = "0.1.5";
    slog = "1.7.1";
    slog_stream = "1.2.1";
    thread_local = "0.3.4";
  };
  deps.smallvec."0.6.7" = {
    unreachable = "1.0.0";
  };
  deps.stable_deref_trait."1.1.1" = { };
  deps.string."0.1.2" = { };
  deps.strsim."0.6.0" = { };
  deps.syn."0.11.11" = {
    quote = "0.3.15";
    synom = "0.11.3";
    unicode_xid = "0.0.4";
  };
  deps.synom."0.11.3" = {
    unicode_xid = "0.0.4";
  };
  deps.tar."0.4.13" = {
    filetime = "0.1.14";
    libc = "0.2.44";
    xattr = "0.1.11";
  };
  deps.tempfile."3.0.5" = {
    cfg_if = "0.1.2";
    rand = "0.6.1";
    remove_dir_all = "0.5.1";
    redox_syscall = "0.1.31";
    libc = "0.2.44";
    winapi = "0.3.6";
  };
  deps.termion."1.5.1" = {
    libc = "0.2.44";
    redox_syscall = "0.1.31";
    redox_termios = "0.1.1";
  };
  deps.textwrap."0.9.0" = {
    unicode_width = "0.1.4";
  };
  deps.thread_id."2.0.0" = {
    kernel32_sys = "0.2.2";
    libc = "0.2.44";
  };
  deps.thread_local."0.2.7" = {
    thread_id = "2.0.0";
  };
  deps.thread_local."0.3.4" = {
    lazy_static = "0.2.10";
    unreachable = "1.0.0";
  };
  deps.time."0.1.38" = {
    libc = "0.2.44";
    redox_syscall = "0.1.31";
    kernel32_sys = "0.2.2";
    winapi = "0.2.8";
  };
  deps.tokio."0.1.7" = {
    futures = "0.1.25";
    mio = "0.6.16";
    tokio_executor = "0.1.5";
    tokio_fs = "0.1.4";
    tokio_io = "0.1.10";
    tokio_reactor = "0.1.7";
    tokio_tcp = "0.1.2";
    tokio_threadpool = "0.1.9";
    tokio_timer = "0.2.5";
    tokio_udp = "0.1.3";
  };
  deps.tokio_codec."0.1.1" = {
    bytes = "0.4.11";
    futures = "0.1.25";
    tokio_io = "0.1.10";
  };
  deps.tokio_executor."0.1.5" = {
    futures = "0.1.25";
  };
  deps.tokio_fs."0.1.4" = {
    futures = "0.1.25";
    tokio_io = "0.1.10";
    tokio_threadpool = "0.1.9";
  };
  deps.tokio_io."0.1.10" = {
    bytes = "0.4.11";
    futures = "0.1.25";
    log = "0.4.6";
  };
  deps.tokio_reactor."0.1.7" = {
    crossbeam_utils = "0.6.1";
    futures = "0.1.25";
    lazy_static = "1.2.0";
    log = "0.4.6";
    mio = "0.6.16";
    num_cpus = "1.8.0";
    parking_lot = "0.6.4";
    slab = "0.4.0";
    tokio_executor = "0.1.5";
    tokio_io = "0.1.10";
  };
  deps.tokio_tcp."0.1.2" = {
    bytes = "0.4.11";
    futures = "0.1.25";
    iovec = "0.1.1";
    mio = "0.6.16";
    tokio_io = "0.1.10";
    tokio_reactor = "0.1.7";
  };
  deps.tokio_threadpool."0.1.9" = {
    crossbeam_deque = "0.6.2";
    crossbeam_utils = "0.6.1";
    futures = "0.1.25";
    log = "0.4.6";
    num_cpus = "1.8.0";
    rand = "0.6.1";
    tokio_executor = "0.1.5";
  };
  deps.tokio_timer."0.2.5" = {
    futures = "0.1.25";
    tokio_executor = "0.1.5";
  };
  deps.tokio_udp."0.1.3" = {
    bytes = "0.4.11";
    futures = "0.1.25";
    log = "0.4.6";
    mio = "0.6.16";
    tokio_codec = "0.1.1";
    tokio_io = "0.1.10";
    tokio_reactor = "0.1.7";
  };
  deps.try_lock."0.2.2" = { };
  deps.unicase."1.4.2" = {
    version_check = "0.1.3";
  };
  deps.unicase."2.1.0" = {
    version_check = "0.1.3";
  };
  deps.unicode_bidi."0.3.4" = {
    matches = "0.1.6";
  };
  deps.unicode_normalization."0.1.5" = { };
  deps.unicode_width."0.1.4" = { };
  deps.unicode_xid."0.0.4" = { };
  deps.unreachable."1.0.0" = {
    void = "1.0.2";
  };
  deps.url."1.6.1" = {
    idna = "0.1.4";
    matches = "0.1.6";
    percent_encoding = "1.0.1";
  };
  deps.utf8_ranges."0.1.3" = { };
  deps.uuid."0.7.1" = {
    rand = "0.5.5";
  };
  deps.vcpkg."0.2.2" = { };
  deps.vec_map."0.8.0" = { };
  deps.version_check."0.1.3" = { };
  deps.void."1.0.2" = { };
  deps.want."0.0.6" = {
    futures = "0.1.25";
    log = "0.4.6";
    try_lock = "0.2.2";
  };
  deps.winapi."0.2.8" = { };
  deps.winapi."0.3.6" = {
    winapi_i686_pc_windows_gnu = "0.4.0";
    winapi_x86_64_pc_windows_gnu = "0.4.0";
  };
  deps.winapi_build."0.1.1" = { };
  deps.winapi_i686_pc_windows_gnu."0.4.0" = { };
  deps.winapi_x86_64_pc_windows_gnu."0.4.0" = { };
  deps.ws2_32_sys."0.2.1" = {
    winapi = "0.2.8";
    winapi_build = "0.1.1";
  };
  deps.xattr."0.1.11" = {
    libc = "0.2.44";
  };
}
