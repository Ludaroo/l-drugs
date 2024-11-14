<template>
  <div class="fixed inset-0 flex items-center justify-center">
    <div class="tablet-container w-full max-w-[80%] h-[90vh] bg-gray-800 border-[20px] border-gray-900 rounded-[3rem] shadow-xl relative">
      <div class="header text-center p-4 text-2xl font-semibold text-white relative">
        {{ t('drugManager.title') }}
        <button @click="closeUI" class="absolute top-2 right-4 text-white">{{ t('drugManager.close') }}</button>
        <div class="locale-changer absolute top-2 left-4">
          <select v-model="locale" @change="changeLocale(locale)" class="bg-gray-800 text-white px-3 py-2 rounded-lg border border-gray-600">
            <option v-for="(lang, code) in languages" :key="code" :value="code">
              {{ lang }}
            </option>
          </select>
        </div>
      </div>
      
      <div class="flex h-full">
        <div class="w-1/5 p-4 bg-gray-900">
          <ul class="space-y-4">
            <li v-for="item in menuItems" :key="item.name" @click="setActiveSection(item.name)"
                :class="{ 'bg-blue-500': item.active }"
                class="cursor-pointer rounded-md p-2 text-white hover:bg-blue-300">
              {{ t(item.label) }}
            </li>
          </ul>
        </div>
        
        <div class="w-4/5 p-6 overflow-auto">
          <!-- Drug List and Add/Edit Panel -->
          <div v-if="activeSection === 'drugConfig'" class="text-white">
            <h2 class="text-xl mb-4">{{ t('drugManager.drugConfigTitle') }}</h2>
            
            <!-- Add Drug Button if No Drugs Exist -->
            <div v-if="drugs.length === 0" class="flex justify-center mt-6">
              <button @click="openAddDrugModal" class="bg-blue-500 text-white px-4 py-2 rounded-lg">
                + {{ t('drugManager.addDrug') }}
              </button>
            </div>
            
            <!-- Drug List -->
            <ul v-else class="mt-2 space-y-2">
              <li v-for="drug in drugs" :key="drug.name" class="bg-gray-700 p-2 rounded-lg cursor-pointer" @click="openEditDrugModal(drug)">
                <p>{{ t('drugManager.drugName') }}: {{ drug.name }}</p>
              </li>
            </ul>
          </div>
        </div>
      </div>
      
      <!-- Add/Edit Drug Modal -->
      <div v-if="showDrugModal" class="modal fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center">
        <div class="bg-gray-800 p-6 rounded-lg w-96">
          <h2 class="text-xl text-white mb-4">{{ editMode ? t('drugManager.editDrug') : t('drugManager.addDrug') }}</h2>
          
          <label class="block mb-2">{{ t('drugManager.drugName') }}:</label>
          <input v-model="currentDrug.name" class="mb-4 w-full px-4 py-2 rounded-lg bg-gray-700 text-white" :placeholder="t('drugManager.drugNamePlaceholder')">
          
          <label class="block mb-2">{{ t('drugManager.healthImpact') }}:</label>
          <input v-model="currentDrug.healthImpact" type="number" class="mb-4 w-full px-4 py-2 rounded-lg bg-gray-700 text-white" :placeholder="t('drugManager.healthImpactPlaceholder')">
          
          <label class="block mb-2">{{ t('drugManager.effectLevel') }}:</label>
          <input v-model="currentDrug.effectLevel" type="number" class="mb-4 w-full px-4 py-2 rounded-lg bg-gray-700 text-white" :placeholder="t('drugManager.effectLevelPlaceholder')">
          
          <label class="block mb-2">{{ t('drugManager.toleranceThreshold') }}:</label>
          <input v-model="currentDrug.toleranceThreshold" type="number" class="mb-4 w-full px-4 py-2 rounded-lg bg-gray-700 text-white" :placeholder="t('drugManager.toleranceThresholdPlaceholder')">
          
          <div class="flex justify-end space-x-4">
            <button @click="saveDrug" class="bg-blue-500 text-white px-4 py-2 rounded-lg">{{ t('drugManager.save') }}</button>
            <button @click="closeDrugModal" class="bg-red-500 text-white px-4 py-2 rounded-lg">{{ t('drugManager.cancel') }}</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, watch, onMounted, onBeforeUnmount } from 'vue';
import { useI18n } from 'vue-i18n';

const { t } = useI18n();
const locale = ref(localStorage.getItem('locale') || 'en');
const languages = {
  en: t('language.english'),
  de: t('language.german'),
  zhcn: t('language.chinese')
};

const menuItems = ref([{ name: 'drugConfig', label: 'drugManager.menuDrugConfig', active: true }]);
const activeSection = ref('drugConfig');

const drugs = ref([]);  // Existing drugs list
const showDrugModal = ref(false);  // Controls modal visibility
const editMode = ref(false);  // Track if adding or editing
const currentDrug = ref({ name: '', healthImpact: 0, effectLevel: 0, toleranceThreshold: 0 });

// Locale & section functions
const setActiveSection = (sectionName) => {
  menuItems.value.forEach(item => item.active = item.name === sectionName);
  activeSection.value = sectionName;
};

const changeLocale = (newLocale) => {
  localStorage.setItem('locale', newLocale);
  locale.value = newLocale;
};

// Modal functions
const openAddDrugModal = () => {
  currentDrug.value = { name: '', healthImpact: 0, effectLevel: 0, toleranceThreshold: 0 };
  editMode.value = false;
  showDrugModal.value = true;
};

const openEditDrugModal = (drug) => {
  currentDrug.value = { ...drug };
  editMode.value = true;
  showDrugModal.value = true;
};

const closeDrugModal = () => showDrugModal.value = false;

const saveDrug = () => {
  if (editMode.value) {
    const index = drugs.value.findIndex(d => d.name === currentDrug.value.name);
    if (index !== -1) drugs.value[index] = { ...currentDrug.value };
  } else {
    drugs.value.push({ ...currentDrug.value });
  }
  closeDrugModal();
};

// UI functions
const closeUI = () => {
  fetch(`https://${GetParentResourceName()}/ToggleUI`, { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({}) });
};

const handleEscapeKey = (event) => {
  if (event.key === 'Escape') closeUI();
};

watch(locale, (newLocale) => changeLocale(newLocale));

onMounted(() => {
  document.addEventListener('keydown', handleEscapeKey);
  const savedLocale = localStorage.getItem('locale');
  if (savedLocale) locale.value = savedLocale;
});

onBeforeUnmount(() => {
  document.removeEventListener('keydown', handleEscapeKey);
});
</script>

<style scoped>
.tablet-container {
  border: 20px solid #1c1c1e;
  border-radius: 3rem;
  box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.3);
}

.modal {
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
