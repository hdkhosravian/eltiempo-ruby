describe './bin/eltiempo executing a CLI Application' do
  context "call the cli min temp successfully" do
    it 'with -today' do
      # we can't use stub request here because the cli is an external library
      expect { run_cli("./bin/eltiempo", '-today', 'Gavamar') }.to output(
        a_string_including
      ).to_stdout_from_any_process
    end

    it 'with today' do
      # we can't use stub request here because the cli is an external library
      expect { run_cli("./bin/eltiempo", 'today', 'Gavamar') }.to output(
        a_string_including
      ).to_stdout_from_any_process
    end
  end
  
  it "list of cities contain name of the city" do
    # we can't use stub request here because the cli is an external library
    expect { run_cli("./bin/eltiempo", '-today', 'Gav') }.to output(
      a_string_including('we could not find the Gav, did you mean:')
    ).to_stdout_from_any_process
  end

  it "return error message if the name of city was wrong" do
    # we can't use stub request here because the cli is an external library
    expect { run_cli("./bin/eltiempo", '-today', 'test') }.to output(
      a_string_including('we could not find the test')
    ).to_stdout_from_any_process
  end
end
