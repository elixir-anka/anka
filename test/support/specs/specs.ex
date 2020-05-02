defmodule Spec do
  def document() do
    [
      name: [
        singular: :document,
        plural: :documents
      ],
      struct: [
        fields: [
          :id,
          content: [
            opts: [
              default: ""
            ]
          ]
        ]
      ]
    ]
  end
end
