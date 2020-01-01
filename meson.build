project('rac', ['c', 'vala'],
    version: '0.0.1',
    license: 'MIT'
)

c_args = [
    '-O1',
    '-g'
]

sources = files(
    'core.vala',
    'rac.vala',
    'drivers/list.vala'
)

dependencies = [
    dependency('gio-2.0')
]

e = executable('rac',
    sources: sources,
    c_args: c_args,
    dependencies: dependencies,
    install : false
)
