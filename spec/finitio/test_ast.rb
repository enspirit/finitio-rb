require 'spec_helper'
describe Finitio, "ast" do

  subject{
    Finitio.ast <<-EOF
      Posint = .Fixnum( i | i>=0 )
      Point  = { x: Posint, y: Posint }
      {{ p: Point }}
    EOF
  }

  let(:expected){
    [ :system,
      [ :type_def,
        "Posint",
        [ :sub_type,
          [:builtin_type, "Fixnum"],
          [ :constraint,
            "default",
            [:fn, [:parameters, "i"], [:source, "i>=0"] ]
          ]
        ]
      ],
      [ :type_def,
        "Point",
        [ :tuple_type,
          [ :heading,
            [:attribute, "x", [:type_ref, "Posint"]],
            [:attribute, "y", [:type_ref, "Posint"]]
          ]
        ]
      ],
      [ :relation_type,
        [ :heading,
          [:attribute, "p", [:type_ref, "Point"]]
        ]
      ]
    ]
  }

  it{ should eq(expected) }

end
