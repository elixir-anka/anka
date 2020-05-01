defmodule Spec.User do
  def spec() do
    [
      name: [
        singular: :user,
        plural: :users
      ],
      struct: [
        fields: [
          :id,
          :username
        ]
      ]
    ]
  end
end
