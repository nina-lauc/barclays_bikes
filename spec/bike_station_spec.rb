require_relative '../lib/bike_station' 

describe BikeStation do
	let(:van) { double(:van) }
	let(:bikestation) { BikeStation.new(van) }


	it 'should have 20 bike spaces' do
		expect(bikestation.slots_in_bikestation).to eq (10)
	end

	it 'bikes plus empty spaces should equal 20' do 
		expect(bikestation.sum_of_empty_spaces_and_bikes).to eq (10)
	end


	it 'has 20 bikes at start' do 
		expect(bikestation.number_of_bikes_in_bikestation).to eq (10)
	end

	it 'should have a van associated with it' do
		expect(bikestation.van).to eq van
	end


	context 'someone rents one bike and after someone returns another' do

		it 'should have 19 bikes available' do	
			bikestation.rent_bike(1)
			expect(bikestation.number_of_bikes_in_bikestation).to eq (9)
		end

		it 'should have one empty space' do 
			bikestation.rent_bike(1)
			expect(bikestation.number_of_empty_spaces).to eq (1)
		end

		it 'should have no empty spaces after someone returns a bike' do
			bikestation.rent_bike(1)
			bikestation.return_bike(1)
			expect(bikestation.number_of_empty_spaces).to eq (0)
			expect(bikestation.number_of_bikes_in_bikestation).to eq (10)
		end
	end 


	context ' a bike gets returned broken' do

		it 'should classify the bike as broken when the user presses the broken button' do
			# bikestation.user_presses_broken_button(1)
			expect(bikestation.classify_as_broken).to be_true
		end

		it 'should decrease the number of available bikes' do
			bikestation.classify_as_broken
			expect(bikestation.number_of_bikes_available).to eq (9)
		end

		it 'should not increase the number of empty spaces' do
			bikestation.classify_as_broken
			expect(bikestation.number_of_empty_spaces).to eq (0)
		end


		it 'should contact the van to pick up the bike' do
			expect(van).to receive :asked_for_pickup
			bikestation.request_pickup_broken_bike
		end
	end


	context ' a broken bike gets picked up by the van' do

		it 'should increase one empty space in the bike station' do
		bikestation.bike_went_to_repair
		expect(bikestation.number_of_empty_spaces).to eq(1)
		end
	end






end


