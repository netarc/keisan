require "spec_helper"

RSpec.describe Keisan::Variables::DefaultRegistry do
  let(:registry) { described_class.registry }

  it "contains correct variables" do
    expect(registry["PI"].value).to eq Math::PI
    expect(registry["E"].value).to eq Math::E
    expect(registry["I"].value).to eq Complex(0,1)

    expect(Keisan::AST.parse("PI").value).to eq Math::PI
    expect(Keisan::AST.parse("E").value).to eq Math::E
    expect(Keisan::AST.parse("I").value).to eq Complex(0,1)
  end

  it "is unmodifiable" do
    expect { registry.register!(:bad, false) }.to raise_error(Keisan::Exceptions::UnmodifiableError)
  end

  it "creates local variable when conflicting with variable in default registry" do
    calculator = Keisan::Calculator.new
    calculator.evaluate("PI = 3")

    expect(calculator.evaluate("PI").value).to eq 3
    expect(registry["PI"].value).to eq Math::PI
  end
end
