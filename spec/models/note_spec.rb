require 'spec_helper'

describe Note do
    let(:contact) { FactoryGirl.create(:contact) }
    let(:user) { FactoryGirl.create(:user) }
    before { @note = contact.notes.build(subject: 'Hello world!', content: 'lem ipsum') }


  subject { @note }

  it { should respond_to(:contact_id) }
  it { should respond_to(:subject) }
  it { should respond_to(:content) }


  it 'should create a new instance given valid attributes' do
    Note.create!(user_id: 1,
                 contact_id: 1,
                 subject: 'Hello world!',
                 content: 'This is some content for the note!')
  end

  describe 'when contact id is not present' do
    before { @note.contact_id = '' }
    it { should_not be_valid }
  end

  describe 'when subject is not present' do
    before { @note.subject = '' }
    it { should_not be_valid }
  end

  describe 'when subject is too long' do
    before { @note.subject = 'a' * 51 }
    it { should_not be_valid }
  end

  describe 'when content is not present' do
    before { @note.content = '' }
    it { should_not be_valid }
  end
end
