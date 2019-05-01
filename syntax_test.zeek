# SYNTAX TEST "Zeek.sublime-syntax"

# A test of Sublime Text syntax highlighting for the Zeek language.
#                                                                 ^ comment.line
# <- comment.line punctuation.definition.comment

##! A Zeexygen-style summmary comment.
#                                    ^ comment.line
#^^ punctuation.definition.comment
# <- comment.line punctuation.definition.comment

@load base/frameworks/notice
#    ^ meta.preprocessor
# <- meta.preprocessor keyword.other

@if ( F )
#     ^ constant.language
# <- meta.preprocessor keyword.other
@endif

module Example;
#             ^ punctuation.terminator
#      ^ entity.name.namespace
# <- keyword.other

export {
# <- keyword.other

  type SimpleEnum: enum { ONE, TWO, THREE };
  #                ^ storage.type.enum keyword.declaration.enum
  #              ^ punctuation.separator
  #    ^ entity.name.enum
  # <- keyword.other

  redef enum SimpleEnum += {
  #                     ^ keyword.operator
  #          ^ entity.name.enum
  #     ^ storage.type.enum
  # <- keyword.other

    ## A Zeexygen-style comment.
  # ^^ comment.line punctuation.definition.comment
    FOUR,
    #   ^ punctuation.separator
    FIVE, ##< A Zeexygen-style comment.
        # ^^^ comment.line punctuation.definition.comment
  };

  type SimpleRecord: record {
  #                  ^ storage.type.struct.record keyword.declaration.struct.record
  #                ^ punctuation.separator
  #    ^ entity.name.struct.record
  # <- keyword.other

    field1: count;
    #       ^ storage.type
    #     ^ punctuation.separator
    field2: bool;
    #       ^ storage.type
  } &redef;
  # ^ storage.modifier.attribute

  redef record SimpleRecord += {
  #                         ^ keyword.operator
  #            ^ entity.name.struct.record
  #     ^ storage.type.struct.record
  # <- keyword.other

    field3: string &optional;
    #              ^ storage.modifier.attribute
    #       ^ storage.type

    field4: string &default="blah";
    #                            ^ punctuation.definition.string.end
    #                       ^^^^^^ string.quoted.double
    #                       ^ punctuation.definition.string.begin
  };

  const init_option: bool = T;
  #                         ^ constant.language
  #                       ^ keyword.operator
  #                  ^ storage.type
  # <- storage.modifier

  option runtime_option: bool = F;
  #                             ^ constant.language
  #                           ^ keyword.operator
  #                      ^ storage.type
  # <- storage.modifier

  global test_opaque: opaque of md5;
  #                             ^ storage.type
  #                          ^ keyword.operator
  #                   ^ storage.type
  # <- storage.modifier

  global myfunction: function(msg: string, c: count &default=0): count;
  #                  ^ storage.type

  global myhook: hook(tag: string);
  #              ^ storage.type

  global myevent: event(tag: string);
  #               ^ storage.type
}

function myfunction(msg: string, c: count): count
#        ^ entity.name.function
# <- storage.type
  {
  print "in myfunction", msg, c;
  # <- keyword.other
  return 0;
  # <- keyword.control
  }

event myevent(msg: string) &priority=1
#                          ^ storage.modifier
#     ^ entity.name.function.event
# <- storage.type
  {
  print "in myevent";
  }

hook myhook(msg: string)
#     ^ entity.name.function.hook
# <- storage.type
  {
  print "in myevent";
  }

event zeek_init()
  {
  local b = T;
  # <- storage.modifier
  local s = "\xff\xaf\"andmore";
  #                           ^ punctuation.definition.string.end
  #                  ^^ constant.character.escape
  #          ^^ constant.character.escape
  local p = /foo|bar\xbe\/andmore/;
  #                              ^ punctuation.definition.string.end
  #                     ^^ constant.character.escape
  #                 ^^ constant.character.escape
  #         ^^^^^^^^^^^^^^^^^^^^^^ string.regexp
  #         ^ punctuation.definition.string.begin
  local c = 10;
  #         ^ constant.numeric.integer.decimal

  local sr = SimpleRecord($field1 = 0, $field2 = T, $field3 = "hi");
  #                       ^ punctuation.accessor

  print sr?$field3, sr$field1;
  #                   ^ punctuation.accessor
  #       ^^ punctuation.accessor

  local myset: set[string] = set("one", "two", "three");
  #                          ^ storage.type
  #            ^ storage.type

  add myset["four"];
  # <- keyword.other
  delete myset["one"];
  # <- keyword.other

  for ( ms in myset )
    #      ^ keyword.operator
    {
    print ms is string, s as string;
    #                     ^ keyword.operator
    #        ^ keyword.operator

    print s[1:3];
    #        ^ punctuation.separator

    local tern: count = s == "two" ? 2 : 0;
    #                                  ^ keyword.operator
    #                              ^ keyword.operator

    if ( ms !in myset )
       #    ^^^ keyword.operator
       print fmt("%s, %4.2f: %s", "msg", 3.14, "wtf?");
       #                     ^^ constant.other.placeholder
       #              ^^^^^ constant.other.placeholder
    }

  switch ( c ) {
  # <- keyword.control
  case 1:
  # <- keyword.control
    break;
    # <- keyword.control
  case 2:
  # <- keyword.control
    fallthrough;
    # <- keyword.control
  default:
  # <- keyword.control
    break;
  }

  if ( ! b )
  #    ^ keyword.operator
  # <- keyword.control
    print "here";
  else
  # <- keyword.control
    print "there";

  while ( c != 0 )
  #         ^^ keyword.operator
  # <- keyword.control
    {
    if ( c >= 5 )
    #      ^^ keyword.operator
      c += 0;
    #   ^^ keyword.operator
    else if ( c == 8 )
    #           ^^ keyword.operator
      c -= 0;
    #   ^^ keyword.operator

    c = c / 1;
    #     ^ keyword.operator
    c = c / 1;
    c = c - 1;
    #     ^ keyword.operator
    }

  print |myset|;
  #           ^ keyword.operator
  #     ^ keyword.operator
  print ~5;
  #     ^ keyword.operator
  print 1 & 0xff;
  #       ^ keyword.operator
  print 2 ^ 5;
  #       ^ keyword.operator

  myfunction("hello function");
  # <- entity.name.function.call
  hook myhook("hell hook");
  #    ^ entity.name.function.hook
  # <- storage.type
  event myevent("hello event");
  #     ^ entity.name.function.event
  # <- storage.type
  schedule 1sec { myevent("hello scheduled event") };
  # <- keyword.control

  print 0, 7;
  #        ^ constant.numeric.integer.decimal
  #     ^ constant.numeric.integer.decimal
  print 0xff, 0xdeadbeef;
  #           ^ constant.numeric.integer.hexadecimal
  #     ^ constant.numeric.integer.hexadecimal

  print 3.14159;
  #     ^ constant.numeric.float.decimal
  print 1234.0;
  #     ^ constant.numeric.float.decimal
  print 1234e0;
  #     ^ constant.numeric.float.decimal
  print .003E-23;
  #     ^ constant.numeric.float.decimal
  print .003E+23;
  #     ^ constant.numeric.float.decimal

  print 123/udp;
  #     ^ constant.numeric.port
  print 8000/tcp;
  #     ^ constant.numeric.port
  print 13/icmp;
  #     ^ constant.numeric.port
  print 42/unknown;
  #     ^ constant.numeric.port

  print google.com;
  #     ^ constant.numeric.hostname
  print 192.168.50.1;
  #     ^ constant.numeric.addr
  print 255.255.255.255;
  #     ^ constant.numeric.addr
  print 0.0.0.0;
  #     ^ constant.numeric.addr

  print 10.0.0.0/16;
  #              ^ constant.numeric.integer.decimal
  #             ^ keyword.operator
  #     ^ constant.numeric.addr

  print [2001:0db8:85a3:0000:0000:8a2e:0370:7334];
  #     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ constant.numeric.addr
  # test for case insensitivity
  print [2001:0DB8:85A3:0000:0000:8A2E:0370:7334];
  #     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ constant.numeric.addr
  # any case mixture is allowed
  print [2001:0dB8:85a3:0000:0000:8A2E:0370:7334];
  #     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ constant.numeric.addr
  # leading zeroes of a 16-bit group may be omitted
  print [2001:db8:85a3:0:0:8a2e:370:7334];
  #     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ constant.numeric.addr
  # a single occurrence of consecutive groups of zeroes may be replaced by ::
  print [2001:db8:85a3::8a2e:370:7334];
  #     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ constant.numeric.addr
  # all zeroes should work
  print [0:0:0:0:0:0:0:0];
  #     ^^^^^^^^^^^^^^^^^ constant.numeric.addr
  # all zeroes condensed should work
  print [::];
  #     ^^^^ constant.numeric.addr
  # hybrid ipv6-ipv4 address should work
  print [2001:db8:0:0:0:FFFF:192.168.0.5];
  #     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ constant.numeric.addr
  # hybrid ipv6-ipv4 address with zero ommission should work
  print [2001:db8::FFFF:192.168.0.5];
  #     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ constant.numeric.addr

  print [2001:0db8:85a3:0000:0000:8a2e:0370:7334]/64;
  #                                               ^^ constant.numeric.integer
  #                                              ^ keyword.operator
  #     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ constant.numeric.addr

  print 1day, 1days, 1.0day, 1.0days;
  #                          ^^^^^^^ constant.numeric.float.decimal.interval
  #                  ^^^^^^ constant.numeric.float.decimal.interval
  #           ^^^^^ constant.numeric.float.decimal.interval
  #     ^^^^ constant.numeric.float.decimal.interval
  print 1hr, 1hrs, 1.0hr, 1.0hrs;
  #                       ^^^^^^ constant.numeric.float.decimal.interval
  print 1min, 1mins, 1.0min, 1.0mins;
  #                          ^^^^^^^ constant.numeric.float.decimal.interval
  print 1sec, 1secs, 1.0sec, 1.0secs;
  #                          ^^^^^^^ constant.numeric.float.decimal.interval
  print 1msec, 1msecs, 1.0msec, 1.0msecs;
  #                             ^^^^^^^^ constant.numeric.float.decimal.interval
  print 1usec, 1usecs, 1.0usec, 1.0usecs;
  #                             ^^^^^^^^ constant.numeric.float.decimal.interval
  }
