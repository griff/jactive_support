require 'java'
require 'active_support'
require 'jactive_support/core_ext/enum_compare'

describe 'enum' do

  it 'returns matching enum object when calling find_value_of with exact named symbol or string' do
    java::lang::Thread::State.find_value_of(:NEW).should be(java::lang::Thread::State::NEW)
    java::lang::Thread::State.find_value_of('NEW').should be(java::lang::Thread::State::NEW)
  end
  
  it 'returns matching enum object when calling find_value_of with underscored symbol or string' do
    java::lang::Thread::State.find_value_of(:n_e_w).should be(java::lang::Thread::State::NEW)
    java::lang::Thread::State.find_value_of('n_e_w').should be(java::lang::Thread::State::NEW)
  end

  it 'fails when calling find_value_of with value not in enum' do
    expect {
      java::lang::Thread::State.find_value_of(:MISSING)
    }.to raise_error(NativeException, "java.lang.IllegalArgumentException: No enum const class java.lang.Thread$State.MISSING")

    expect {
      java::lang::Thread::State.find_value_of(:missing_link)
    }.to raise_error(NativeException, "java.lang.IllegalArgumentException: No enum const class java.lang.Thread$State.missing_link")
  end

  it 'should be comparable with a symbol when using ===' do
    t = java::lang::Thread::State::NEW
    t.should === :NEW
    :NEW.should === t
  end

  it 'should be comparable with an underscored symbol when using ===' do
    t = java::lang::Thread::State::NEW
    t.should === :n_e_w
    :n_e_w.should === t
  end

  it 'should be comparable with a string when using ===' do
    t = java::lang::Thread::State::NEW
    t.should === 'NEW'
    'NEW'.should === t
  end


  it 'should be comparable with an underscored string when using ===' do
    t = java::lang::Thread::State::NEW
    t.should === 'n_e_w'
    'n_e_w'.should === t
  end
  
  it 'should return the enum object when calling to_java on a symbol or string with enum class as argument' do
    :NEW.to_java(java::lang::Thread::State).should be(java::lang::Thread::State::NEW)
    'NEW'.to_java(java::lang::Thread::State).should be(java::lang::Thread::State::NEW)
    :n_e_w.to_java(java::lang::Thread::State).should be(java::lang::Thread::State::NEW)
    'n_e_w'.to_java(java::lang::Thread::State).should be(java::lang::Thread::State::NEW)
  end

  it 'fails when calling to_java on a symbol or string whose value can not be found in the provided enum class' do
    expect {
      :MISSING.to_java(java::lang::Thread::State)
      }.to raise_error(TypeError, "No enum const class java.lang.Thread$State.MISSING")
    expect {
      'MISSING'.to_java(java::lang::Thread::State)
    }.to raise_error(TypeError, "No enum const class java.lang.Thread$State.MISSING")
  end
end