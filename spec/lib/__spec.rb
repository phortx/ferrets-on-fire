describe '_' do
  subject { Class.new { require '_' } }

  it 'includes the module' do
    expect(subject).to be_a(FoF)
  end

  it 'provides the DSL' do
    expect(subject).to respond_to(:load_lib)
  end
end
