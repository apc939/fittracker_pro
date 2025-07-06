import React, { useState } from 'react';

const UserPreference: React.FC = () => {
  const [preferences, setPreferences] = useState({
    fitnessLevel: '',
    goals: [] as string[],
    notifications: true
  });

  const fitnessLevels = ['Beginner', 'Intermediate', 'Advanced'];
  const goalOptions = ['Weight Loss', 'Muscle Gain', 'Endurance', 'Flexibility', 'General Health'];

  const handleGoalToggle = (goal: string) => {
    setPreferences(prev => ({
      ...prev,
      goals: prev.goals.includes(goal)
        ? prev.goals.filter(g => g !== goal)
        : [...prev.goals, goal]
    }));
  };

  const handleComplete = () => {
    console.log('User preferences:', preferences);
    // Here you would typically save preferences and navigate to main app
    alert('Preferences saved! Welcome to FitTracker Pro!');
  };

  return (
    <div className="min-h-screen bg-white p-6">
      <div className="max-w-md mx-auto">
        <div className="text-center mb-8">
          <h1 className="text-3xl font-bold text-gray-900 mb-2">Personalize Your Experience</h1>
          <p className="text-gray-600">Help us customize FitTracker Pro for you</p>
        </div>

        <div className="space-y-8">
          {/* Fitness Level */}
          <div>
            <h3 className="text-lg font-semibold text-gray-900 mb-4">What's your fitness level?</h3>
            <div className="space-y-3">
              {fitnessLevels.map((level) => (
                <button
                  key={level}
                  onClick={() => setPreferences(prev => ({ ...prev, fitnessLevel: level }))}
                  className={`w-full p-4 rounded-lg border-2 text-left transition-colors ${
                    preferences.fitnessLevel === level
                      ? 'border-primary-600 bg-primary-50 text-primary-700'
                      : 'border-gray-200 hover:border-gray-300'
                  }`}
                >
                  {level}
                </button>
              ))}
            </div>
          </div>

          {/* Goals */}
          <div>
            <h3 className="text-lg font-semibold text-gray-900 mb-4">What are your fitness goals?</h3>
            <div className="space-y-3">
              {goalOptions.map((goal) => (
                <button
                  key={goal}
                  onClick={() => handleGoalToggle(goal)}
                  className={`w-full p-4 rounded-lg border-2 text-left transition-colors ${
                    preferences.goals.includes(goal)
                      ? 'border-primary-600 bg-primary-50 text-primary-700'
                      : 'border-gray-200 hover:border-gray-300'
                  }`}
                >
                  <div className="flex items-center justify-between">
                    <span>{goal}</span>
                    {preferences.goals.includes(goal) && (
                      <svg className="w-5 h-5 text-primary-600" fill="currentColor" viewBox="0 0 20 20">
                        <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
                      </svg>
                    )}
                  </div>
                </button>
              ))}
            </div>
          </div>

          {/* Notifications */}
          <div>
            <div className="flex items-center justify-between p-4 bg-gray-50 rounded-lg">
              <div>
                <h3 className="text-lg font-semibold text-gray-900">Enable Notifications</h3>
                <p className="text-sm text-gray-600">Get reminders and motivation</p>
              </div>
              <button
                onClick={() => setPreferences(prev => ({ ...prev, notifications: !prev.notifications }))}
                className={`relative inline-flex h-6 w-11 items-center rounded-full transition-colors ${
                  preferences.notifications ? 'bg-primary-600' : 'bg-gray-300'
                }`}
              >
                <span
                  className={`inline-block h-4 w-4 transform rounded-full bg-white transition-transform ${
                    preferences.notifications ? 'translate-x-6' : 'translate-x-1'
                  }`}
                />
              </button>
            </div>
          </div>
        </div>

        <button
          onClick={handleComplete}
          disabled={!preferences.fitnessLevel || preferences.goals.length === 0}
          className="w-full mt-8 bg-primary-600 text-white py-4 rounded-lg font-semibold text-lg hover:bg-primary-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
        >
          Complete Setup
        </button>
      </div>
    </div>
  );
};

export default UserPreference;