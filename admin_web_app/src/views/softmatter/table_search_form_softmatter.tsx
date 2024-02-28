import React, { useState, ChangeEvent } from 'react';
import { TextField, MenuItem, Select } from '@mui/material';

interface MyComponentProps {
  initialValues?: Record<string, string>; // You can pass initial values as props
  onInputChange?: (field: string, value: string) => void; // Callback to handle input changes
}

const MyComponent: React.FC<MyComponentProps> = ({ initialValues = {}, onInputChange }) => {
  // State to manage input values
  const [fieldValues, setFieldValues] = useState(initialValues);

  // Function to handle input changes
  const handleInputChangeLocal = (fieldName: string) => (event: ChangeEvent<HTMLInputElement | { value: string }>) => {
    const newValue = event.target.value;
    setFieldValues((prevValues) => ({
      ...prevValues,
      [fieldName]: newValue,
    }));

    // Invoke the parent component's callback if provided
    if (onInputChange) {
      onInputChange(fieldName, newValue);
    }
  };

  const textFieldStyle: React.CSSProperties = {
    marginRight: '8px', // Adjust margin as needed
  };

  return (
    <div style={{ display: 'flex', gap: '8px' }}>
      {/* Your 7 textfields go here */}
      <TextField
        label="Field 1"
        variant="outlined"
        fullWidth
        value={fieldValues.field1 || ''}
        onChange={handleInputChangeLocal('field1')}
        style={textFieldStyle}
      />
      <TextField
        label="Field 2"
        variant="outlined"
        fullWidth
        value={fieldValues.field2 || ''}
        onChange={handleInputChangeLocal('field2')}
        style={textFieldStyle}
      />
    </div>
  );
};

export default MyComponent;
