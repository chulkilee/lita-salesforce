require 'spec_helper'

describe Lita::Handlers::Salesforce, lita_handler: true do
  it 'handles unknown type' do
    send_message('@lita salesforce unknown_type id')
    expect(replies.last).to eq("Sorry, I don't know which fields to fetch for unknown_type sobject.")
  end

  it 'does not reply to non-command' do
    send_message('salesforce unknown_type id')
    expect(replies.last).to be_nil
  end

  context 'with mock client' do
    let(:client) { double('client') }
    let(:sobject) do
      {
        'Name' => 'opp-name',
        'StageName' => 'opp-stage',
        'CloseDate' => '2015-01-01',
        'IsClosed' => '2015-12-31',
        'Account' => { 'Id' => 'account-id', 'Name' => 'account-name' },
        'Owner' => { 'Name' => 'owner-name' }
      }
    end
    let(:fields) { described_class::DEFAULT_FIELDS_BY_OBJECT['opportunity'] }
    let(:expected) do
      %(Name: opp-name
StageName: opp-stage
CloseDate: 2015-01-01
IsClosed: 2015-12-31
Account.Id: account-id
Account.Name: account-name
Owner.Name: owner-name)
    end

    before(:each) do
      expect(Restforce).to receive(:new) { client }
    end

    it 'shows text from salesforce' do
      expect(client).to receive(:select).with('opportunity', 'abc', fields, 'Id') { sobject }
      send_message('@lita salesforce opportunity abc')
      expect(replies.last).to eq(expected)
    end

    it 'handles type alias' do
      expect(client).to receive(:select).with('opportunity', 'abc', fields, 'Id') { sobject }
      send_message('@lita salesforce opp abc')
      expect(replies.last).to eq(expected)
    end

    it 'handles error from salesforce' do
      expect(client).to receive(:select).with('opportunity', 'abc', fields, 'Id') { fail StandardError, 'some error' }
      send_message('@lita salesforce opp abc')
      expect(replies.last).to eq("Sorry, I couldn't get the date due to error: StandardError (some error)")
    end
  end
end
