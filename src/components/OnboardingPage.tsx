import React from 'react';

interface OnboardingPageProps {
  title: string;
  description: string;
  image: string;
}

const OnboardingPage: React.FC<OnboardingPageProps> = ({ title, description, image }) => {
  return (
    <div className="text-center max-w-sm mx-auto">
      <div className="mb-12">
        <div className="text-8xl mb-8">{image}</div>
        <h2 className="text-3xl font-bold text-gray-900 mb-4">{title}</h2>
        <p className="text-lg text-gray-600 leading-relaxed">{description}</p>
      </div>
    </div>
  );
};

export default OnboardingPage;