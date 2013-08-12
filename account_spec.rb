require_relative "account"

describe Account do

  let(:valid_account_number) { "1234567890" }
  let(:account) { Account.new(valid_account_number) }

  describe "#initialize" do
    it "should be a valid account number" do
      expect(account.acct_number).to eq("******7890")
    end
    it "should raise InvalidAccountNumebrError" do 
      expect { Account.new('qwertyuuiiop') }.to raise_error(InvalidAccountNumberError)
    end
    it "should have a starting balance of 0" do
      expect(account.balance).to eq(0)
    end
  end

  describe "#transactions" do
    it "should make a deposit and increase the balance" do
      expect(account.deposit!(500)).to eq(500)  
    end

    it "should make a withdrawal and decrease the balance" do
      expect(Account.new("0987654321", 500).withdraw!(200)).to eq(300)
    end

    it "should raise a OverdraftError for withdrawing" do
      expect { Account.new("0987654321", 20).withdraw!(21) }.to raise_error(OverdraftError)
    end

    it "should raise a NegativeDepositError for depositing a negative balance" do
      expect { Account.new("0987654321", 50).deposit!(-25) }.to raise_error(NegativeDepositError)
    end
  end

  describe "#balance" do
    it "should return 0" do
      expect(account.balance).to eq(0)
    end

    it "should return the sum of transactions" do
      account.should_receive(:transactions) { [10, 20]}
      expect(account.balance).to eq(30)
    end
  end

  describe "#account_number" do
    it "should mask an account number" do
      expect(account.acct_number).to include('******')
    end
  end

  describe "deposit!" do
    it "should make a deposit" do
      expect(account.deposit!(100)).to eq(100) 
    end
  end

  describe "#withdraw!" do
    it "should make a withdrawal" do
      expect(Account.new("0987654321", 100).withdraw!(50) ).to eq(50)
    end
  end
end
