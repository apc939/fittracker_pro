import React from 'react';

interface PageIndicatorProps {
  totalPages: number;
  currentPage: number;
}

const PageIndicator: React.FC<PageIndicatorProps> = ({ totalPages, currentPage }) => {
  return (
    <div className="flex space-x-2 my-8">
      {Array.from({ length: totalPages }, (_, index) => (
        <div
          key={index}
          className={`w-3 h-3 rounded-full transition-colors ${
            index === currentPage ? 'bg-primary-600' : 'bg-gray-300'
          }`}
        />
      ))}
    </div>
  );
};

export default PageIndicator;