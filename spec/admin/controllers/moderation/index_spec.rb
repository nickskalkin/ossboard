require_relative '../../../../apps/admin/controllers/moderation/index'

RSpec.describe Admin::Controllers::Moderation::Index do
  let(:action) { described_class.new }
  let(:session) { { current_user: User.new(id: 1, admin: true) } }
  let(:params)  { { 'rack.session' => session } }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
