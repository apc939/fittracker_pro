import React, { useState } from 'react';
import OnboardingPage from './OnboardingPage';
import PageIndicator from './PageIndicator';
import UserPreference from './UserPreference';

const OnboardingFlow: React.FC = () => {
  const [currentPage, setCurrentPage] = useState(0);
  const [showPreferences, setShowPreferences] = useState(false);

  const onboardingPages = [
    {
      title: "Track Your Progress",
      description: "Monitor your fitness journey with detailed analytics and insights",
      image: "🏃‍♂️"
    },
    {
      title: "Set Your Goals",
      description: "Define personalized fitness goals and track your achievements",
      image: "🎯"
    },
    {
      title: "Stay Motivated",
      description: "Get daily reminders and motivation to keep you on track",
      image: "💪"
    }
  ];

  const handleNext = () => {
    if (currentPage < onboardingPages.length - 1) {
      setCurrentPage(currentPage + 1);
    } else {
      setShowPreferences(true);
    }
  };

  const handlePrevious = () => {
    if (currentPage > 0) {
      setCurrentPage(currentPage - 1);
    }
  };

  const handleSkip = () => {
    setShowPreferences(true);
  };

  if (showPreferences) {
    return <UserPreference />;
  }

  return (
    <div className="min-h-screen bg-white flex flex-col">
      <div className="flex-1 flex flex-col justify-center items-center px-6">
        <OnboardingPage
          title={onboardingPages[currentPage].title}
          description={onboardingPages[currentPage].description}
          image={onboardingPages[currentPage].image}
        />
        
        <PageIndicator
          totalPages={onboardingPages.length}
          currentPage={currentPage}
        />
      </div>

      <div className="p-6 space-y-4">
        <button
          onClick={handleNext}
          className="w-full bg-primary-600 text-white py-4 rounded-lg font-semibold text-lg hover:bg-primary-700 transition-colors"
        >
          {currentPage === onboardingPages.length - 1 ? 'Get Started' : 'Next'}
        </button>
        
        <div className="flex justify-between">
          <button
            onClick={handlePrevious}
            disabled={currentPage === 0}
            className="text-secondary-500 font-medium disabled:opacity-50 disabled:cursor-not-allowed"
          >
            Previous
          </button>
          <button
            onClick={handleSkip}
            className="text-secondary-500 font-medium"
          >
            Skip
          </button>
        </div>
      </div>
    </div>
  );
};

export default OnboardingFlow;