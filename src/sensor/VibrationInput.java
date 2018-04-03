package sensor;

public class VibrationInput {
	private String userID;
	private int InputVibrationMeasure;
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getInputVibrationMeasure() {
		return InputVibrationMeasure;
	}
	public void setInputVibrationMeasure(int inputVibrationMeasure) {
		InputVibrationMeasure = inputVibrationMeasure;
	}
}
