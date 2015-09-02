require_relative "../../lib/airplane"
require "rspec"
require "pry"

describe Airplane do
  let(:my_plane) { Airplane.new("cesna", 10, 150, 500) }
  let(:low_fuel_plane) { Airplane.new("cesna", 10, 150, 20) }

  describe "#initialization" do
    context "when the user creates a new plane" do
      it "identifies the correct plane type" do
          expect(my_plane.type).to eq("cesna")
          expect(low_fuel_plane.type).to eq('cesna')
      end

      it "identifies the wing loading of the plane" do
          expect(my_plane.wing_loading).to eq(10)
          expect(low_fuel_plane.wing_loading).to eq(10)
      end

      it "identifies the horsepower of the plane" do
          expect(my_plane.horsepower).to eq(150)
          expect(low_fuel_plane.horsepower).to eq(150)
      end

      it "identifies the quantity of fuel on the plane" do
          expect(my_plane.fuel).to eq(500)
          expect(low_fuel_plane.fuel).to eq(20)
      end

    end
  end

  describe "#start" do
    context "when the user starts the engine and there is sufficient fuel" do
      it "tells the user that the airplane started" do
        my_plane.started = false
        expect { my_plane.start }.to output("The airplane started!\n").to_stdout
        expect(my_plane.started).to eq(true)
        expect(my_plane.fuel).to eq(475)
      end
    end

    context "when the user starts the engine and there is insufficient fuel" do
      it "tells the user that the airplane cannot be started due to low fuel" do
        low_fuel_plane.started = false
        expect { low_fuel_plane.start }.to output("The airplane cannot be started; you need to add fuel!\n").to_stdout
        expect(low_fuel_plane.started).to eq(false)
        expect(low_fuel_plane.fuel).to eq(20)
      end
    end

    context "when the plane was already started" do
      it "tells the user that the airplane has already been running" do
        my_plane.started = true
        expect { my_plane.start }.to output("The airplane has already been running!\n").to_stdout
        expect(my_plane.fuel).to eq(500)
      end
    end
  end

  describe "#takeoff" do
    context "when the user attempts takeoff and the plane has already started" do
      it "tells the user that the plane has taken off" do
        my_plane.started = true
        expect { my_plane.takeoff}.to output("The plane has taken off.\n").to_stdout
        expect(my_plane.flying).to eq(true)
        expect(my_plane.fuel).to eq(475)
      end
    end

    context "when the user attempts takeoff and the plane has already started but has low fuel" do
      it "tells the user that the plane can not take off due to low fuel" do
        low_fuel_plane.started = true
        expect { low_fuel_plane.takeoff}.to output("The plane does not have enough fuel to take off.\n").to_stdout
        expect(low_fuel_plane.flying).to eq(false)
        expect(low_fuel_plane.fuel).to eq(20)
      end
    end

    context "when the user attempts takeoff and the plane has not been started" do
      it "tells the user that the plane must be started first" do
        my_plane.started = false
        expect { my_plane.takeoff }.to output("The plane has not been started; please start.\n").to_stdout
        expect(my_plane.flying).to eq(false)
        expect(my_plane.fuel).to eq(500)
      end
    end
  end

  describe '#land' do
    context "when the user attempts to land the plane and the plane is flying" do
      it "tells the user that the airplane has landed" do
        my_plane.started = true
        my_plane.flying = true
        expect { my_plane.land }.to output("The airplane has landed!\n").to_stdout
        expect(my_plane.landed).to eq(true)
        expect(my_plane.flying).to eq(false)
        expect(my_plane.fuel).to eq(400)
      end
    end

    context "when the user attempts to land the plane and the plane is flying, but is low on fuel" do
      it "tells the user that the airplane does not have enough fuel to land - prepare for emergency landing" do
        low_fuel_plane.started = true
        low_fuel_plane.flying = true
        expect { low_fuel_plane.land }.to output("The airplane does not have enough fuel to land - prepare for emergency landing!\n").to_stdout
        expect(low_fuel_plane.landed).to eq(false)
        expect(low_fuel_plane.flying).to eq(true)
        expect(low_fuel_plane.fuel).to eq(20)
      end
    end

    context "when the user attempts to land the plane and the plane has started but is not flying" do
      it "tells the user that the airplane is already on the ground" do
        my_plane.started = true
        my_plane.flying = false
        expect { my_plane.land }.to output("The airplane is already on the ground!\n").to_stdout
        expect(my_plane.landed).to eq(false)
        expect(my_plane.fuel).to eq(500)
      end
    end

    context "when the user attempts to land the plane and the plane has not been started" do
      it "tells the user that the airplane must be started in order to fly" do
        my_plane.started = false
        my_plane.flying = false
        expect { my_plane.land }.to output("The airplane must be started in order to fly!\n").to_stdout
        expect(my_plane.landed).to eq(false)
      end
    end
  end
end
