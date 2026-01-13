describe 'Sample automation test' do
  before(:all) do
    @client = OpenStruct.new(name: 'John')
  end

  it 'does many things at once' do
    @client.name = 'Mike'
    find(:xpath, "//div[text()='Save']").click
    expect(@client.name).to eq('Mike')
    expect(1).to eq(1)
    expect(2).to eq(2)
    expect(3).to eq(3)
    expect(4).to eq(4)
  end
end
