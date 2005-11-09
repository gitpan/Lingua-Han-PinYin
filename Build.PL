use strict;
use Module::Build;

my $build = Module::Build->new(
    create_makefile_pl => 'passthrough',
    license            => 'perl',
    module_name        => 'Lingua::Han::PinYin',
    requires           => {
        'Encode' => 0,
        'File::Spec' => 0,
    },
);
$build->add_build_element('dat');
$build->create_build_script;
